#!/usr/bin/env bash
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function createEnvironment() {
  echo "Y" | make create-foundation ENV=${1} && \
  echo "Y" | make create-compute ENV=${1} && \
  echo "Y" | make create-db ENV=${1} && \
  echo "Y" | make create-app-deps ENV=${1} && \
  echo "Y" | make upload-app ENV=${1}
}

cat .make

printf  "\n${YELLOW}This command creates a full riglet based on the environment described above.${NC}\n"
read -p "Are you sure you want to proceed?  " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  make create-deps && \
  createEnvironment integration && \
  createEnvironment staging && \
  createEnvironment production && \
  echo "Y" | make create-build REPO=synapse CONTAINER_PORT=8080 LISTENER_RULE_PRIORITY=100 && \
  echo "Y" | make create-build REPO=eolas CONTAINER_PORT=4200 LISTENER_RULE_PRIORITY=200 && \
  echo "Y" | make create-build REPO=illuminate CONTAINER_PORT=4400 LISTENER_RULE_PRIORITY=300
fi

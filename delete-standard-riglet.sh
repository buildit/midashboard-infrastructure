#!/usr/bin/env bash
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

cat .make

printf "\n${YELLOW}***${NC} For a clean deletion you must delete the images contained in the ECS repo for this riglet.\n\n"

printf "${RED}This will delete the riglet environment described above.${NC}\n"
read -p "Are you sure you want to proceed?  " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Y" | make delete-app ENV=integration REPO=synapse
  echo "Y" | make delete-app ENV=staging REPO=synapse
  echo "Y" | make delete-app ENV=production REPO=synapse
  echo "Y" | make delete-build REPO=synapse

  echo "Y" | make delete-app ENV=integration REPO=eloas
  echo "Y" | make delete-app ENV=staging REPO=eloas
  echo "Y" | make delete-app ENV=production REPO=eloas
  echo "Y" | make delete-build REPO=eloas

  echo "Y" | make delete-app ENV=integration REPO=illuminate
  echo "Y" | make delete-app ENV=staging REPO=illuminate
  echo "Y" | make delete-app ENV=production REPO=illuminate
  echo "Y" | make delete-build REPO=illuminate

  echo "YY" | make delete-environment ENV=integration
  echo "YY" | make delete-environment ENV=staging
  echo "YY" | make delete-environment ENV=production
  echo "YY" | make delete-foundation-deps ENV=integration
  echo "YY" | make delete-foundation-deps ENV=staging
  echo "YY" | make delete-foundation-deps ENV=production
  echo "YY" | make delete-deps
fi
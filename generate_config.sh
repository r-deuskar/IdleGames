#!/bin/bash -e
# Reset config file
> ./config.js
# Find all the APPS_ environment variables in the environment
declare -a customVars

env | grep APPS_

for key in $(env | awk -F "=" '{print $1}' | grep ".*APPS_.*")
do
  customVars+=($key)
done
# Recreate a new config.js
for key in "${customVars[@]}"
do
  echo "window.$key='${!key}';" >> ./config.js
done
echo "APPS_SCRIPT_URL=$APPS_SCRIPT_URL"

#!/usr/bin/env bash

echo 'child'
exit 0

# regex
SERVER=$1;
regex_ws="^ws-[0-9]+\.host\.com$"
regex_db="^db-[0-9]+\.host\.com$"
regex_bk="^bk-[0-9]+\.host\.com$"
if [[ "${SERVER}" =~ $regex_ws ]]; then
  echo "Web Server"
elif [[ "${SERVER}" =~ $regex_db ]]; then
  echo "DB server"
elif [[ "${SERVER}" =~ $regex_bk ]]; then
  echo "Backup server"
else
  echo "Unknown server"
fi

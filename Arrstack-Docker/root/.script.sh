#!/bin/bash

port="$1"
QBT_URL=localhost
QBT_USER=$USERNAME                                                                          # Replace $USERNAME with your qbittorrent username
QBT_PASS=$PASSWORD                                                                          # Replace $PASSWORD with your qbittorrent password
QBT_PORT=8090

echo "Setting qBittorrent port settings ($port)..."
# Very basic retry logic so we dont fail if qBittorrent isn't running yet
 while ! curl --silent --retry 100 --retry-delay 30 --max-time 100 \
  --data "username=${QBT_USER}&password=${QBT_PASS}" \
  --cookie-jar /tmp/qb-cookies.txt \
  http://localhost:${QBT_PORT}/api/v2/auth/login
  do
    sleep 30
  done

curl --silent --retry 100 --retry-delay 30 --max-time 100 \
  --data 'json={"listen_port": "'"$port"'"}' \
  --cookie /tmp/qb-cookies.txt \
  http://localhost:${QBT_PORT}/api/v2/app/setPreferences

echo "Qbittorrent port updated successfully ($port)..."

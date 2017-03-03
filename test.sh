#!/bin/bash -ex

# Details: http://www.onegeek.com.au/articles/waiting-for-dependencies-in-docker-compose

echo ">> Waiting for fxa-profile-server to start"
WAIT=0
while ! nc -z 127.0.0.1 1111; do
  sleep 1
  WAIT=$(($WAIT + 1))
  if [ "$WAIT" -gt 30 ]; then
    echo "Error: Timeout"
    exit 1
  fi
done

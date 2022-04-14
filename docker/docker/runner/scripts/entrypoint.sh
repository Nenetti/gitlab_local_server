#!/bin/bash

# ==================================================================================================
#
#   Start Docker Daemon
#
# ==================================================================================================
while true; do
  service docker start
  x=$(docker ps -a 2>&1)
  if [[ ${x} =~ "Cannot connect to the Docker" ]]; then
    echo "failed"
  else
    break
  fi
done
echo "Success to Connect Docker daemon"
docker ps -a

# ==================================================================================================
#
#   Next Command
#
# ==================================================================================================
exec "$@"
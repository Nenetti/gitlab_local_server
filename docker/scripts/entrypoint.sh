#!/bin/bash

# ==================================================================================================
#
#   Start Docker Daemon
#
# ==================================================================================================
function start_docker_daemon() {
  while true; do
    service docker start
    x=$(docker ps -a 2>&1)
    if [[ ${x} =~ "Cannot connect to the Docker" ]]; then
      echo "Failed to connect Docker daemon"
    else
      echo "Success to Connect Docker daemon"
      break
    fi
  done
}

start_docker_daemon

# ==================================================================================================
#
#   Start GitLab Server & Runner
#
# ==================================================================================================
docker-compose -f /root/docker/gitlab/docker-compose.yml stop t 0
docker-compose -f /root/docker/runner/docker-compose.yml stop t 0

docker-compose -f /root/docker/gitlab/docker-compose.yml up --build

#docker-compose -f /root/docker/gitlab/docker-compose.yml up -d --build
#docker-compose -f /root/docker/runner/docker-compose.yml up -d --build
#docker-compose -f /root/docker/runner/docker-compose.yml up --build

# ==================================================================================================
#
#   Next Command
#
# ==================================================================================================
exec "$@"

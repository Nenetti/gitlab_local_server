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
SERVER_FILE=/root/docker/gitlab/docker-compose.yml
RUNNER_FILE=/root/docker/runner/docker-compose.yml

docker-compose -f ${SERVER_FILE} stop t 0
docker-compose -f ${RUNNER_FILE} stop t 0

docker-compose -f ${SERVER_FILE} up -d --build

while true; do
  STATUS_CODE=$(curl "http://gitlab.example.com" -o /dev/null -w '%{http_code}\n' -s)
  if [[ ${STATUS_CODE} = "302" ]]; then
    break
  fi
  sleep 1
done

echo "Connected"
docker-compose -f /root/docker/runner/docker-compose.yml up -d --build

# ==================================================================================================
#
#   Backup (PIPE)
#
# ==================================================================================================
#PIPE=/tmp/server.pipe
#if [ -e ${PIPE} ]; then
#  rm ${PIPE}
#fi
#mkfifo ${PIPE}
#docker-compose -f ${SERVER_FILE} logs -f --since 0s | tee ${PIPE} >/dev/null &
#PID=$!
#
#cat ${PIPE} | while read line; do
#  if [[ ${line} =~ "Checking if we already upgraded: OK" ]]; then
#    echo "a ${line}"
#    break
#  else
#    echo "a ${line}"
#  fi
#done
#
#echo $PID
#rm /tmp/server.pipe

# ==================================================================================================
#
#   Next Command
#
# ==================================================================================================
exec "$@"

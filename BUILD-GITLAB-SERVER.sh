#!/bin/bash

cd docker || exit
docker-compose build
sudo mkdir -p \
  /srv/gitlab-server/volumes \
  /srv/gitlab-server/docker \
  /srv/gitlab-server/volumes/gitlab/config \
  /srv/gitlab-server/volumes/gitlab/logs \
  /srv/gitlab-server/volumes/gitlab/data \
  /srv/gitlab-server/volumes/runner/volumes/config \
  /srv/gitlab-server/volumes/runner/docker

docker-compose up
#docker exec gitlab-server bash -c "docker-compose -f /root/docker/gitlab/docker-compose.yml up"
#docker-compose stop

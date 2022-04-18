#!/bin/bash

if [[ -z "${CI_SERVER_URL}" ]]; then
  echo "Error: CI_SERVER_URL environment variable not set."
  exit 1
fi

if [[ -z "${REGISTRATION_TOKEN}" ]]; then
  echo "Error: REGISTRATION_TOKEN environment variable not set."
  exit 1
fi

gitlab-runner register \
  --non-interactive \
  --config "/etc/gitlab-runner/config.toml" \
  --url "${CI_SERVER_URL}" \
  --registration-token "${REGISTRATION_TOKEN}" \
  --executor "docker" \
  --description "docker-runner" \
  --tag-list "docker" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected" \
  --docker-image "ubuntu:20.04" \
  --docker-gpus="all" \
  --docker-network-mode="host"

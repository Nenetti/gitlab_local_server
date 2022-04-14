# General guidelines and recommendations for writing 'Dockerfile':
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
# ==================================================================================================
#
#   Initialize Ubuntu Focal Fossa (20.04 LTS).
#
# ==================================================================================================
ARG FROM_IMAGE
FROM ${FROM_IMAGE}
MAINTAINER Kanechika

# ==================================================================================================
#
#   etc
#
# ==================================================================================================
# $ docker inspect gitlab/gitlab-ce:latest
#    "Cmd": [
#        "/assets/wrapper"
#    ],
#    "Entrypoint": null,

COPY scripts/daemon.json /etc/docker/daemon.json
RUN chmod 644 /etc/docker/daemon.json

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/assets/wrapper"]

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
#   Install Docker
#
# ==================================================================================================
# https://docs.docker.com/engine/install/ubuntu/

# ------------------------- #
#       Version
# ------------------------- #
ARG DOCKER_VERSION=*
ARG CONTAINERD_IO_VERSION=*

# ------------------------- #
#       Install
# ------------------------- #
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-ce=${DOCKER_VERSION} \
    docker-ce-cli=${DOCKER_VERSION}  \
    containerd.io=${CONTAINERD_IO_VERSION} \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ==================================================================================================
#
#   Install Docker-Compose
#
# ==================================================================================================
# https://docs.docker.com/compose/install/

#  ------------------------ #
#       Version
# ------------------------- #
# https://github.com/docker/compose/releases
ARG DOCKER_COMPOSE_VERSION="v2.4.1"

# ------------------------- #
#       Install
# ------------------------- #
RUN curl -s -L https://github.com/docker/compose/releases/download/"${DOCKER_COMPOSE_VERSION}"/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# ==================================================================================================
#
#   Install Nvidia-Docker2
#
# ==================================================================================================
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker

# ------------------------- #
#       Version
# ------------------------- #
ARG NVIDIA_DOCKER2_VERSION=*

# ------------------------- #
#       Install
# ------------------------- #
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
    && curl -s -L https://nvidia.github.io/libnvidia-container/"$(. /etc/os-release;echo $ID$VERSION_ID)"/libnvidia-container.list \
        | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
        | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    nvidia-docker2=${NVIDIA_DOCKER2_VERSION} \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ==================================================================================================
#
#   Docker in Docker
#
# ==================================================================================================
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

COPY scripts/daemon.json /etc/docker/daemon.json
RUN chmod 644 /etc/docker/daemon.json

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]


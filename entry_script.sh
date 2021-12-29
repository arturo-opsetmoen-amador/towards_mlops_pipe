#!/bin/bash
# Setup docker group based on hosts mount gid
echo "Adding hosts GID to docker system group"
# This only works if the docker group does not already exist
DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker
BUILD_USER=arturo

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})

    # addgroup is distribution specific

    addgroup --system --gid ${DOCKER_GID} ${DOCKER_GROUP}
    addgroup  ${BUILD_USER} ${DOCKER_GROUP}
fi

# Check for mlflow parameters and run the mlflow pipeline.
# We use hydra parameters ("hydra_options=...")

if [[ -z "${MLFLOW_RUN_PARAMS}" ]]; then
  su -c 'cd ${WORKING_DIRECTORY}/ && mlflow run . ' arturo
else
  su -c 'cd ${WORKING_DIRECTORY}/ && mlflow run . -P ${MLFLOW_RUN_PARAMS} ' arturo
fi



#!/bin/bash
# *******************************************************************
#             __  __  ___  _  _  ___   ___ _    ___
#            |  \/  |/ _ \| \| |/ _ \ / __| |  | __|
#            | |\/| | (_) | .` | (_) | (__| |__| _|
#            |_|  |_|\___/|_|\_|\___/ \___|____|___|
#
# -------------------------------------------------------------------
#                    MONOCLE GATEWAY SERVICE
# -------------------------------------------------------------------
#
#  This script builds the Docker image for the Monocle Gateway
#  Service.  This docker container is based on Linux Alpine and
#  supports both [x64] and [ARM64] architectures.
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

# Monocle Gateway Version
VERSION=v0.0.5

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: BUILD DOCKER IMAGE"
echo "------------------------------------------------------------"
echo ">> BUILDING MONOCLE GATEWAY DOCKER IMAGE: $VERSION"
echo "------------------------------------------------------------"

# BUILD AND PUSH DOCKER IMAGE

# use buildx to create a new builder instance; if needed
docker buildx create --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10485760   \
                     --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=100000000 \
                     --use --name monocle-gateway-buildx || true;

# perform multi-arch platform image builds; push the resulting image to the DockerHub repository
# (https://hub.docker.com/r/monoclecam/monocle-gateway)
docker buildx build \
  --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg BUILDVERSION="$VERSION" \
  --platform linux/amd64,linux/arm64 \
  --push \
  --tag monoclecam/monocle-gateway:$VERSION \
  --tag monoclecam/monocle-gateway:latest . $@

# remove the builder instance when completed
docker buildx rm monocle-gateway-buildx


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
#  This script build the Docker image for the Monocle Gateway Service
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: BUILD DOCKER IMAGE"
echo "------------------------------------------------------------"

# GET VERSION FROM VERSION FILE
BUILD_VERSION="$(cat VERSION)"

# CREATE DATE STAMP
BUILD_DATE=`date +%Y-%m-%d`

echo ">> BUILDING MONOCLE GATEWAY DOCKER IMAGE: $BUILD_VERSION"

# BUILD AND TAG DOCKER IMAGE
docker build                                      \
  --no-cache                                      \
  --tag monoclecam/monocle-gateway:latest         \
  --tag monoclecam/monocle-gateway:$BUILD_VERSION \
  --build-arg BUILD_VERSION=$BUILD_VERSION        \
  --build-arg BUILD_DATE=$BUILD_DATE              \
  --rm=true                                       \
  .

echo ">> MONOCLE GATEWAY DOCKER IMAGE COMPLETE:"
docker images --filter=reference="monoclecam/monocle-gateway:*"
echo "------------------------------------------------------------"

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
#  This script removes the latest tagged Docker image available in the
#  local Docker image repository for the Monocle Gateway Service as
#  well as any locally running Monocle Gateway Docker containers.
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: REMOVE CONTAINER & IMAGE"
echo "------------------------------------------------------------"

# GET VERSION FROM VERSION FILE
BUILD_VERSION="$(cat VERSION)"

# CHECK FOR EXISTING MONOCLE GATEWAY CONTAINER
echo ">> CHECKING FOR EXISTING MONOCLE GATEWAY CONTAINER"
if docker ps -q --filter "name=monocle-gateway" | grep -q . ;then
  echo ">> FOUND EXISTING MONOCLE GATEWAY CONTAINER"

  # STOP MONOCLE GATEWAY DOCKER CONTAINER
  echo ">> STOPPING EXISTING MONOCLE GATEWAY CONTAINER"
  docker stop monocle-gateway

  # REMOVE MONOCLE GATEWAY DOCKER CONTAINER
  echo ">> REMOVING EXISTING MONOCLE GATEWAY CONTAINER"
  docker rm -f monocle-gateway
else
  echo ">> NO EXISTING MONOCLE GATEWAY CONTAINER FOUND"
fi

# REMOVE MONOCLE GATEWAY DOCKER IMAGE
echo ">> REMOVING EXISTING MONOCLE GATEWAY IMAGES"
docker rmi -f monoclecam/monocle-gateway
docker rmi -f monoclecam/monocle-gateway:$BUILD_VERSION

echo ">> REMOVAL COMPLETE FOR MONOCLE GATEWAY CONTAINER AND IMAGES"
echo "------------------------------------------------------------"

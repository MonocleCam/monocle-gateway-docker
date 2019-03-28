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
#  This script purges all tagged Docker images available in the
#  local Docker image repository for the Monocle Gateway Service.
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: PURGE CONTAINER & ALL LOCAL IMAGES"
echo "------------------------------------------------------------"

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

# REMOVE ALL MONOCLE GATEWAY DOCKER IMAGES
IMAGES=`docker images --filter=reference="monoclecam/monocle-gateway:*"  -q`
if [ -z "$IMAGES" ];then
  echo ">> NO EXISTING MONOCLE GATEWAY IMAGES FOUND"
else
  echo ">> PURGING ALL EXISTING MONOCLE GATEWAY IMAGES"
  docker images --filter=reference="monoclecam/monocle-gateway:*"
  docker rmi -f $(docker images --filter=reference="monoclecam/monocle-gateway:*" -q)
fi

echo ">> PURGE COMPLETE FOR MONOCLE GATEWAY CONTAINER AND IMAGES"
echo "------------------------------------------------------------"

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
#  This script pushes/deploys tagged Docker images to the Docker Hub
#  image repository for the Monocle Gateway Service.
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: DEPLOY/PUSH DOCKER IMAGES"
echo "------------------------------------------------------------"

# GET VERSION FROM VERSION FILE
BUILD_VERSION="$(cat VERSION)"

# PUSH MONOCLE GATEWAY DOCKER IMAGES
echo ">> DEPLOYING MONOCLE GATEWAY IMAGES"
docker push monoclecam/monocle-gateway
docker push monoclecam/monocle-gateway:$BUILD_VERSION

echo ">> DEPLOYMENT/PUSH COMPLETE FOR MONOCLE GATEWAY IMAGES"
echo "------------------------------------------------------------"

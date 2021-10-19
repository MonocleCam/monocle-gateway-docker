#!/bin/bash -e
# *********************************************************************
#              __  __  ___  _  _  ___   ___ _    ___
#             |  \/  |/ _ \| \| |/ _ \ / __| |  | __|
#             | |\/| | (_) | .` | (_) | (__| |__| _|
#             |_|  |_|\___/|_|\_|\___/ \___|____|___|
#
#  -------------------------------------------------------------------
#                  MONOCLE GATEWAY DOCKER IMAGE
#        COPYRIGHT SHADEBLUE, LLC @ 2018, ALL RIGHTS RESERVED
#  -------------------------------------------------------------------
#
# *********************************************************************

# run monocle-gateway inside test environment container
docker pull monoclecam/monocle-gateway:latest
docker run --rm -it \
      --platform linux/amd64 \
      --volume /etc/monocle:/etc/monocle \
      monoclecam/monocle-gateway:latest $@


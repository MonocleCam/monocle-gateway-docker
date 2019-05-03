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
#  This script provides an example of the docker start command used
#  to launch a new Monocle Gateway service Docker container.
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
#
# *******************************************************************

echo "------------------------------------------------------------"
echo " MONOCLE GATEWAY :: START DOCKER CONTAINER"
echo "------------------------------------------------------------"

# REMOVE EXISTING MONOCLE GATEWAY CONTAINER
echo ">> CHECKING FOR EXISTING MONOCLE GATEWAY CONTAINER"
if docker ps -q --filter "name=monocle-gateway" | grep -q . ;then
  echo ">> FOUND EXISTING MONOCLE GATEWAY CONTAINER"
  echo ">> REMOVING EXISTING MONOCLE GATEWAY CONTAINER"
  docker rm -f monocle-gateway
else
  echo ">> NO EXISTING MONOCLE GATEWAY CONTAINER FOUND"
fi

# CREATE NETWORK
docker network create --driver bridge --ipv6 \
  --subnet  172.10.0.0/16 \
  --gateway 172.10.0.1 \
  --subnet  2001:db8:1::/64 \
  --gateway 2001:db8:1::1 \
  bridge-routed

# CREATE AND RUN NEW MONOCLE GATEWAY CONTAINER
echo ">> STARTING NEW MONOCLE GATEWAY CONTAINER"
docker run                           \
  -it                                \
  -d                                 \
  --restart=always                   \
  --volume /etc/monocle:/etc/monocle \
  --name=monocle-gateway             \
  --network bridge-routed            \
  monoclecam/monocle-gateway

echo ">> NEW MONOCLE GATEWAY CONTAINER IS RUNNING"
echo "------------------------------------------------------------"

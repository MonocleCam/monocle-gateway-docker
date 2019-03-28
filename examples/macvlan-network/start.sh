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

# CUSTOM NETWORK SETTINGS (for macvlan)
NETWORK_INTERFACE=eth0
NETWORK_SUBNET=10.1.0.0/16
NETWORK_GATEWAY=10.1.1.1
NETWORK_ADDRESS=10.1.1.199

# REMOVE EXISTING MONOCLE GATEWAY CONTAINER
echo ">> CHECKING FOR EXISTING MONOCLE GATEWAY CONTAINER"
if docker ps -q --filter "name=monocle-gateway" | grep -q . ;then
  echo ">> FOUND EXISTING MONOCLE GATEWAY CONTAINER"
  echo ">> REMOVING EXISTING MONOCLE GATEWAY CONTAINER"
  docker rm -f monocle-gateway
else
  echo ">> NO EXISTING MONOCLE GATEWAY CONTAINER FOUND"
fi

# REMOVE EXISTING MONOCLE GATEWAY MACVLAN NETWORK
echo ">> CHECKING FOR EXISTING MONOCLE GATEWAY NETWORK"
if docker network ls -q --filter "name=monocle-gateway" | grep -q . ;then
  echo ">> FOUND EXISTING MONOCLE GATEWAY NETWORK"
  echo ">> REMOVING EXISTING MONOCLE GATEWAY NETWORK"
  docker network rm monocle-gateway-network
else
  echo ">> NO EXISTING MONOCLE GATEWAY NETWORK FOUND"
fi

# CREATE NET MACVLAN NETWORK FOR MONOCLE GATEWAY
echo ">> CREATING NEW MONOCLE GATEWAY NETWORK (macvlan)"
docker network create             \
   -d macvlan                     \
   --subnet=$NETWORK_SUBNET       \
   --gateway=$NETWORK_GATEWAY     \
   -o parent=$NETWORK_INTERFACE   \
   monocle-gateway-network

# CREATE AND RUN NEW MONOCLE GATEWAY CONTAINER
echo ">> STARTING NEW MONOCLE GATEWAY CONTAINER"
docker run                           \
  -it                                \
  --detach                           \
  --restart=always                   \
  --volume /etc/monocle:/etc/monocle \
  --name=monocle-gateway             \
  --network=monocle-gateway-network  \
  --ip=$NETWORK_ADDRESS              \
  monoclecam/monocle-gateway

echo ">> NEW MONOCLE GATEWAY CONTAINER IS RUNNING"
echo "------------------------------------------------------------"

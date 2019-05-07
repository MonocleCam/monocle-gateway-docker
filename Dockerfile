# *********************************************************************
#             __  __  ___  _  _  ___   ___ _    ___
#            |  \/  |/ _ \| \| |/ _ \ / __| |  | __|
#            | |\/| | (_) | .` | (_) | (__| |__| _|
#            |_|  |_|\___/|_|\_|\___/ \___|____|___|
#
# -------------------------------------------------------------------
#                    MONOCLE GATEWAY SERVICE
# -------------------------------------------------------------------
#
#  The Monocle Gateway Service is a small service that you install
#  and run inside your network to order to facilitate communication
#  between the Monocle (cloud) platform and your IP cameras. 
#
# -------------------------------------------------------------------
#        COPYRIGHT SHADEBLUE, LLC @ 2019, ALL RIGHTS RESERVED
# -------------------------------------------------------------------
# 
# *********************************************************************

# ---------------------------------------
# Start with the base Alpine Linux image
# ---------------------------------------
FROM alpine:latest
WORKDIR /root

# ---------------------------------------
# Monocle Gateway image arguments.
# ---------------------------------------
ARG BUILD_VERSION=v0.0.4

# ---------------------------------------
# Monocle Gateway image labels.
# ---------------------------------------
LABEL name="Monocle Gateway"
LABEL url="https://monoclecam.com"
LABEL image="monoclecam/monocle-gateway"
LABEL maintainer="support@monoclecam.com"
LABEL description="This image provides a Docker container for the Monocle Gateway service based on Alpine Linux."
LABEL vendor="shadeBlue, LLC."
LABEL version=$BUILD_VERSION

# ---------------------------------------
# Create Monocle Gateway configuration 
# directory
# ---------------------------------------
RUN mkdir -p /etc/monocle

# ---------------------------------------
# Install Monocle Gateway dependencies
# and other useful utilties
# ---------------------------------------
RUN apk update &&      \
    apk add --no-cache \
    wget               \
    curl               \
    libstdc++          \
    nano               \
    net-tools          \
    openssl            \
    ca-certificates

# ---------------------------------------
# Download versioned Monocle Gateway
# build archive file
# - - - - - - - - - - - - - - - - - - - -
# Extract Moncole Gateway related 
# executables to the appropriate 
# runtime directories 
# - - - - - - - - - - - - - - - - - - - -
# Remove the downloaded Monocle Gateway 
# archive files
# ---------------------------------------
RUN wget -c https://files.monoclecam.com/monocle-gateway/linux/monocle-gateway-alpine-x64-$BUILD_VERSION.tar.gz -O monocle-gateway.tar.gz && \
    cd /usr/local/bin/ && \
    tar xvzf /root/monocle-gateway.tar.gz monocle-gateway && \ 
    tar xvzf /root/monocle-gateway.tar.gz monocle-proxy  && \
    rm /root/monocle-gateway.tar.gz

# ---------------------------------------
# Expose required TCP ports 
# (port 443 is required by Amazon for 
# secure connectivity)
# ---------------------------------------
EXPOSE 443/tcp

# ---------------------------------------
# Expose required UDP ports 
# (used for the @proxy method to allow 
# IP cameras to transmit streams via UDP)
# ---------------------------------------
EXPOSE 62000-62100/udp

# ---------------------------------------
# Launch the Monocle Gateway executable 
# (on container startup)
# ---------------------------------------
CMD [ "monocle-gateway" ]

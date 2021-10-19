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
ARG BUILDVERSION
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Robert Savage "support@monoclecam.com"

# ---------------------------------------
# Monocle Gateway image labels.
# ---------------------------------------
LABEL name="Monocle Gateway"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="monoclecam/monocle-gateway"
LABEL org.label-schema.description="This image provides a Docker container for the Monocle Gateway service based on Alpine Linux."
LABEL org.label-schema.url="https://monoclecam.com/"
LABEL org.label-schema.vcs-url="https://github.com/MonocleCam/monocle-gateway-docker"
LABEL org.label-schema.vendor="shadeBlue, LLC."
LABEL org.label-schema.version=$BUILDVERSION
LABEL org.label-schema.architecture=$TARGETARCH

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER MONOCLE-GATEWAY IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

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
RUN wget -c https://files.monoclecam.com/monocle-gateway/linux/monocle-gateway-alpine-x64-$BUILDVERSION.tar.gz -O monocle-gateway.tar.gz && \
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

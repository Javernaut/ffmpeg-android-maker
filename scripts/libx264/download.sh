#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

# Libx264 doesn't have any versioning system. Currently it has 2 branches: master and stable.
# Latest commit in stable branch
# 2 April 2025 at 09:40:08 CEST
LIBX264_VERSION=b35605ace3ddf7c1a5d67a2eb553f034aef41d55

downloadTarArchive \
  "libx264" \
  "https://code.videolan.org/videolan/x264/-/archive/${LIBX264_VERSION}/x264-${LIBX264_VERSION}.tar.gz"

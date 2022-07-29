#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

# Libx264 doesn't have any versioning system. Currently it has 2 branches: master and stable.
# Latest commit in stable branch
# 01 Jun, 2022
LIBX264_VERSION=baee400fa9ced6f5481a728138fed6e867b0ff7f

downloadTarArchive \
  "libx264" \
  "https://code.videolan.org/videolan/x264/-/archive/${LIBX264_VERSION}/x264-${LIBX264_VERSION}.tar.gz"

#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

# Libx264 doesn't have any versioning system. Currently it has 2 branches: master and stable.
# Latest commit in stable branch
# Jun 13, 2021 3:43pm GMT+0300
LIBX264_VERSION=5db6aa6cab1b146e07b60cc1736a01f21da01154

downloadTarArchive \
  "libx264" \
  "https://code.videolan.org/videolan/x264/-/archive/${LIBX264_VERSION}/x264-${LIBX264_VERSION}.tar.gz"

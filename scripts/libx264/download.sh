#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

# Libx264 doesn't have any versioning system. Currently it has 2 branches: master and stable.
# Latest commit in stable branch
# Tue Jun 30 22:28:05 2020 +0300
LIBX264_VERSION=cde9a93319bea766a92e306d69059c76de970190

downloadTarArchive \
  "libx264" \
  "https://code.videolan.org/videolan/x264/-/archive/${LIBX264_VERSION}/x264-${LIBX264_VERSION}.tar.gz"

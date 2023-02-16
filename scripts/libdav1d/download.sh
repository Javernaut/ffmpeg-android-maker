#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

DAV1D_VERSION=1.1.0

downloadTarArchive \
  "libdav1d" \
  "https://code.videolan.org/videolan/dav1d/-/archive/${DAV1D_VERSION}/dav1d-${DAV1D_VERSION}.tar.gz"

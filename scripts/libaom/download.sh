#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

AOM_VERSION=v2.0.2

downloadTarArchive \
  "libaom" \
  "https://aomedia.googlesource.com/aom/+archive/${AOM_VERSION}.tar.gz" \
  true

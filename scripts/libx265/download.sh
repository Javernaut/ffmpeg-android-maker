#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

LIBX265_VERSION=3.6

#  For 3.6 (and presumably above) it is necessary to pass 'true' as the last argument
downloadTarArchive \
  "libx265" \
  "https://bitbucket.org/multicoreware/x265_git/downloads/x265_${LIBX265_VERSION}.tar.gz" \
  true
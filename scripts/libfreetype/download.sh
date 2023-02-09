#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

FREETYPE_VERSION=2.13.0

downloadTarArchive \
  "libfreetype" \
  "https://nav.dl.sourceforge.net/project/freetype/freetype2/${FREETYPE_VERSION}/freetype-${FREETYPE_VERSION}.tar.gz"

#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

FREETYPE_VERSION=2.14.1

downloadTarArchive \
  "libfreetype" \
  "https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz"

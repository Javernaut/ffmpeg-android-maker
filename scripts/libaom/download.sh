#!/usr/bin/env bash

# Script to download AV1 Codec Library's source code

# Exports SOURCES_DIR_libaom - path where actual sources are stored

# This 2 variables have to be changed at once.
# The first one is produced by 'git describe' command while being in the commit represented by the second one.
AOM_VERSION=v1.0.0-errata1-avif
AOM_HASH=4eb1e7795b9700d532af38a2d9489458a8038233

echo "Using libaom $AOM_VERSION"
AOM_SOURCES=libaom-${AOM_VERSION}

if [[ ! -d "$AOM_SOURCES" ]]; then
  TARGET_FILE_NAME=${AOM_VERSION}.tar.gz

  curl https://aomedia.googlesource.com/aom/+archive/${AOM_HASH}.tar.gz --output ${TARGET_FILE_NAME}
  mkdir $AOM_SOURCES
  tar xf ${TARGET_FILE_NAME} -C $AOM_SOURCES
  rm ${TARGET_FILE_NAME}
fi

export SOURCES_DIR_libaom=$(pwd)/${AOM_SOURCES}

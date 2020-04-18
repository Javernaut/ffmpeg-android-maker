#!/usr/bin/env bash

# Script to download Opus's source code

# Exports SOURCES_DIR_libopus - path where actual sources are stored

OPUS_VERSION=1.3.1
echo "Using libopus $OPUS_VERSION"
OPUS_SOURCES=opus-${OPUS_VERSION}

if [[ ! -d "$OPUS_SOURCES" ]]; then
  TARGET_FILE_NAME=opus-${OPUS_VERSION}.tar.gz

  curl https://archive.mozilla.org/pub/opus/${TARGET_FILE_NAME} --output ${TARGET_FILE_NAME}
  tar xf ${TARGET_FILE_NAME} -C .
  rm ${TARGET_FILE_NAME}
fi

export SOURCES_DIR_libopus=$(pwd)/${OPUS_SOURCES}

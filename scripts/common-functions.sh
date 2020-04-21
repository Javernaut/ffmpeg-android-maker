#!/usr/bin/env bash

# Function that downloads an archive with the source code by the given url,
# extracts its files and exports a variable SOURCES_DIR_lib${LIBRARY_NAME}
function downloadArchive() {
  LIBRARY_NAME=$1
  LIBRARY_VERSION=$2
  DOWNLOAD_URL=$3

  echo "Ensuring sources of $LIBRARY_NAME $LIBRARY_VERSION"
  LIBRARY_SOURCES=${LIBRARY_NAME}-${LIBRARY_VERSION}

  if [[ ! -d "$LIBRARY_SOURCES" ]]; then
    curl -O ${DOWNLOAD_URL}

    ARCHIVE_NAME=${DOWNLOAD_URL##*/}
    tar xf ${ARCHIVE_NAME} -C .
    rm ${ARCHIVE_NAME}
  fi

  export SOURCES_DIR_lib${LIBRARY_NAME}=$(pwd)/${LIBRARY_SOURCES}
}

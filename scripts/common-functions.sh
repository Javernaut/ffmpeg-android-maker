#!/usr/bin/env bash

# Function that downloads an archive with the source code by the given url,
# extracts its files and exports a variable SOURCES_DIR_${LIBRARY_NAME}
function downloadTarArchive() {
  # The full name of the library
  LIBRARY_NAME=$1
  # The url of the source code archive
  DOWNLOAD_URL=$2

  ARCHIVE_NAME=${DOWNLOAD_URL##*/}
  # Name of the directory after the archive extraction
  LIBRARY_SOURCES="${ARCHIVE_NAME%.tar.*}"

  echo "Ensuring sources of $LIBRARY_SOURCES"

  if [[ ! -d "$LIBRARY_SOURCES" ]]; then
    curl -O ${DOWNLOAD_URL}

    tar xf ${ARCHIVE_NAME} -C .
    rm ${ARCHIVE_NAME}
  fi

  export SOURCES_DIR_${LIBRARY_NAME}=$(pwd)/${LIBRARY_SOURCES}
}

#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

export MBEDTLS_VERSION=2.28.0
downloadTarArchive \
  "mbedtls" \
  "https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/v${MBEDTLS_VERSION}.tar.gz" \
  true
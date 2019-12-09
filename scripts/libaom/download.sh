# Script to download AV1 Codec Library's source code

# Exports SOURCES_DIR_libaom - path where actual sources are stored

AOM_VERSION=v1.0.0-errata1
echo "Using libaom $AOM_VERSION"
AOM_SOURCES=libaom-${AOM_VERSION}

if [[ ! -d "$AOM_SOURCES" ]]; then
  TARGET_FILE_NAME=${AOM_VERSION}.tar.gz

  curl https://aomedia.googlesource.com/aom/+archive/${TARGET_FILE_NAME} --output ${TARGET_FILE_NAME}
  mkdir $AOM_SOURCES
  tar xf ${TARGET_FILE_NAME} -C $AOM_SOURCES
  rm ${TARGET_FILE_NAME}
fi

export SOURCES_DIR_libaom=$(pwd)/${AOM_SOURCES}

source scripts/parse-arguments.sh
source scripts/export-host-variables.sh

function prepareOutput() {
  OUTPUT_LIB=${OUTPUT_DIR}/lib/${ANDROID_ABI}
  mkdir -p ${OUTPUT_LIB}
  # CURRENT_INSTALL_PATH !
  cp ${BUILD_DIR_FFMPEG}/${ANDROID_ABI}/lib/*.so ${OUTPUT_LIB}

  OUTPUT_HEADERS=${OUTPUT_DIR}/include/${ANDROID_ABI}
  mkdir -p ${OUTPUT_HEADERS}
  cp -r ${BUILD_DIR_FFMPEG}/${ANDROID_ABI}/include/* ${OUTPUT_HEADERS}
}

function checkTextRelocations() {
  # Saving stats about text relocation presence.
  # If the result file doesn't have 'TEXTREL' at all, then we are good.
  TEXT_REL_STATS_FILE=${STATS_DIR}/text-relocations.txt
  ${CROSS_PREFIX}readelf --dynamic ${BUILD_DIR_FFMPEG}/${ABI}/lib/*.so | grep 'TEXTREL\|File' >> ${TEXT_REL_STATS_FILE}

  if grep -q TEXTREL ${TEXT_REL_STATS_FILE}; then
    echo "There are text relocations in output files:"
    cat ${TEXT_REL_STATS_FILE}
    exit 1
  fi
}

rm -rf ${BUILD_DIR}
rm -rf ${STATS_DIR}
rm -rf ${OUTPUT_DIR}
mkdir -p ${STATS_DIR}
mkdir -p ${OUTPUT_DIR}

COMPONENTS_TO_BUILD=${EXTERNAL_LIBRARIES[@]}
COMPONENTS_TO_BUILD+=( "ffmpeg" )

for COMPONENT in ${COMPONENTS_TO_BUILD[@]}
do
  export ENSURE_SOURCE_DIR=$SOURCES_DIR/$COMPONENT
  mkdir -p ${ENSURE_SOURCE_DIR}
  source scripts/${COMPONENT}/download.sh
done

# Build all libraries for each enabled arch
# ABIS_TO_BUILD=("armeabi-v7a" "arm64-v8a" "x86" "x86_64")
ABIS_TO_BUILD=("armeabi-v7a")

for ABI in ${ABIS_TO_BUILD[@]}
do
  source scripts/export-build-variables.sh ${ABI}

  for COMPONENT in ${COMPONENTS_TO_BUILD[@]}
  do
    echo "Building the component: ${COMPONENT}"
    COMPONENT_SOURCES_DIR_VARIABLE=SOURCES_DIR_${COMPONENT}
    echo ${!COMPONENT_SOURCES_DIR_VARIABLE}
    cd ${!COMPONENT_SOURCES_DIR_VARIABLE}
    ${SCRIPTS_DIR}/${COMPONENT}/build.sh
    cd $BASE_DIR
  done

  # Check for text rels
  checkTextRelocations

  prepareOutput
done

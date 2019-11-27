# Expecting FFMPEG_SOURCE_TYPE and FFMPEG_SOURCE_VALUE variables

# Think of that names

# Expecting ENSURE_SOURCE_DIR - where source code has to be downloaded
# Exports SOURCES_DIR_FFMPEG - path where actual sources are stored

echo "Downloading sources for FFmpeg"

echo ${FFMPEG_SOURCE_TYPE}
echo ${FFMPEG_SOURCE_VALUE}

# Utility function
# Getting sources of a particular ffmpeg release.
# Same argument (ffmpeg version) produces the same source set.
function ensureSourcesTar() {
  FFMPEG_SOURCES=${ENSURE_SOURCE_DIR}/ffmpeg-${FFMPEG_SOURCE_VALUE}

  if [[ ! -d "$FFMPEG_SOURCES" ]]; then
    TARGET_FILE_NAME=ffmpeg-${FFMPEG_SOURCE_VALUE}.tar.bz2
    TARGET_FILE_PATH=${ENSURE_SOURCE_DIR}/${TARGET_FILE_NAME}

    curl https://www.ffmpeg.org/releases/${TARGET_FILE_NAME} --output ${TARGET_FILE_PATH}
    tar xzf ${TARGET_FILE_PATH} -C ${ENSURE_SOURCE_DIR}
    rm ${TARGET_FILE_PATH}
  fi

  export SOURCES_DIR_ffmpeg=$FFMPEG_SOURCES
}

# Utility function
# Getting sources of a particular branch of ffmpeg's git repository.
# Same argument (branch name) may produce different source set,
# as the branch in origin repository may be updated in future.
# function ensureSourcesBranch() {
#   BRANCH=$1
#
#   GIT_DIRECTORY=ffmpeg-git
#
#   FFMPEG_SOURCES=${SOURCES_DIR}/${GIT_DIRECTORY}
#
#   cd ${SOURCES_DIR}
#
#   if [[ ! -d "$FFMPEG_SOURCES" ]]; then
#     git clone https://git.ffmpeg.org/ffmpeg.git ${GIT_DIRECTORY}
#   fi
#
#   cd ${GIT_DIRECTORY}
#   git checkout $BRANCH
#   # Forcing the update of a branch
#   git pull origin $BRANCH
#
#   # Additional logging to keep track of an exact commit to build
#   echo "Commit to build:"
#   git rev-parse HEAD
#
#   cd ${BASE_DIR}
# }

case ${FFMPEG_SOURCE_TYPE} in
	# GIT_TAG)
  #   echo "Using FFmpeg ${SECOND_ARGUMENT}"
	# 	ensureSourcesTag ${SECOND_ARGUMENT}
	# 	;;
	# GIT_BRANCH)
  #   echo "Using FFmpeg git repository and its branch ${SECOND_ARGUMENT}"
	# 	ensureSourcesBranch ${SECOND_ARGUMENT}
	# 	;;
	TAR)
		echo "Using FFmpeg source archive ${FFMPEG_FALLBACK_VERSION}"
    ensureSourcesTar
		;;
esac

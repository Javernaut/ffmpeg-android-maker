# TODO Add desctiption of in and out params

EXTERNAL_LIBRARIES=()

SOURCE_TYPE=TAR
SOURCE_VALUE="4.2.1"

MIN_SDK=16

for i in "$@"
do
case $i in
    --min-sdk=*)
      MIN_SDK="${i#*=}"
      shift
    ;;
    --source-git-tag=*)
      SOURCE_TYPE=GIT_TAG
      SOURCE_VALUE="${i#*=}"
      shift
    ;;
    --source-git-branch=*)
      SOURCE_TYPE=GIT_BRANCH
      SOURCE_VALUE="${i#*=}"
      shift
    ;;
    --source-tar=*)
      SOURCE_TYPE=TAR
      SOURCE_VALUE="${i#*=}"
      shift
    ;;
    --enable-libaom)
      EXTERNAL_LIBRARIES+=( "libaom" )
      shift
    ;;
    --enable-libdav1d)
      EXTERNAL_LIBRARIES+=( "libdav1d" )
      shift
    ;;
    --enable-libmp3lame)
      EXTERNAL_LIBRARIES+=( "libmp3lame" )
      shift
    ;;
    *)
      echo "Unknown argument $i"
    ;;
esac
done

export FFMPEG_SOURCE_TYPE=$SOURCE_TYPE
export FFMPEG_SOURCE_VALUE=$SOURCE_VALUE
export FFMPEG_EXTERNAL_LIBRARIES=${EXTERNAL_LIBRARIES[@]}

export MIN_SDK_ARG=${MIN_SDK}

# Download sources for all libraries
export BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
export SOURCES_DIR=${BASE_DIR}/sources
export STATS_DIR=${BASE_DIR}/stats
export SCRIPTS_DIR=${BASE_DIR}/scripts
export OUTPUT_DIR=${BASE_DIR}/output
BUILD_DIR=${BASE_DIR}/build
export BUILD_DIR_FFMPEG=$BUILD_DIR/ffmpeg
export BUILD_DIR_EXTERNAL=$BUILD_DIR/external

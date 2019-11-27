# Essential directories

# The root of the project
export BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
# Directory that contains source code for FFmpeg and its dependencies
# Each library has its own subdirectory
# Multiple versions of the same library can be stored inside librarie's directory
export SOURCES_DIR=${BASE_DIR}/sources
# Directory to place some statistics about the build.
# Currently - the info about Text Relocations
export STATS_DIR=${BASE_DIR}/stats
# Directory that contains helper scripts and
# scripts to download and build FFmpeg and each dependency separated by subdirectories
export SCRIPTS_DIR=${BASE_DIR}/scripts
# The directory to use by Android project
# All FFmpeg's libraries and headers are copied there
export OUTPUT_DIR=${BASE_DIR}/output

# Directory to use as a place to build/install FFmpeg and its dependencies
BUILD_DIR=${BASE_DIR}/build
# Separate directory to build FFmpeg to
export BUILD_DIR_FFMPEG=$BUILD_DIR/ffmpeg
# All external libraries are installed to a single root
# to make easier referencing them when FFmpeg is being built.
export BUILD_DIR_EXTERNAL=$BUILD_DIR/external

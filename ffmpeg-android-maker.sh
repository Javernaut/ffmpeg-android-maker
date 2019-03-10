#!/usr/bin/env bash

FFMPEG_VERSION=4.1.1

# Directories used by the script
BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
SOURCES_DIR=${BASE_DIR}/sources
FFMPEG_SOURCES=${SOURCES_DIR}/ffmpeg-${FFMPEG_VERSION}
OUTPUT_DIR=${BASE_DIR}/output
BUILD_DIR=${BASE_DIR}/build

# No incremental compilation here. Just drop what was built previously
rm -rf ${BUILD_DIR}
rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}

# Test if sources of the FFMpeg exist. If not - download them
function ensureSources() {
  if [[ ! -d "$FFMPEG_SOURCES" ]]; then
    TARGET_FILE_NAME=ffmpeg-${FFMPEG_VERSION}.tar.bz2
    TARGET_FILE_PATH=${SOURCES_DIR}/${TARGET_FILE_NAME}

    mkdir -p ${SOURCES_DIR}
    curl https://www.ffmpeg.org/releases/${TARGET_FILE_NAME} --output ${TARGET_FILE_PATH}
    tar xvjf ${TARGET_FILE_PATH} -C ${SOURCES_DIR}
    rm ${TARGET_FILE_PATH}
  fi
}

# Actual magic of configuring and compiling of FFMpeg for a certain architecture.
# Supported architectures are: armeabi-v7a, arm64-v8a, x86 and x86_64
function assemble() {
  cd ${FFMPEG_SOURCES}

  ARCH=$1
  API_LEVEL=$2

  TOOLCHAIN_PATH=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/darwin-x86_64
  SYSROOT=${TOOLCHAIN_PATH}/sysroot

  CC_ANDROID_POSTFIX=
  EXTRA_CFLAGS=
  EXTRA_CONFIGURE_FLAGS=

  case $ARCH in
  	armeabi-v7a)
      FFMPEG_ARCH_FLAG=arm
      CROSS_PREFIX=arm-linux-androideabi-
      CC_PREFIX=armv7a
      CC_ANDROID_POSTFIX=eabi
  		;;
  	arm64-v8a)
      FFMPEG_ARCH_FLAG=aarch64
      CROSS_PREFIX=aarch64-linux-android-
      CC_PREFIX=aarch64
  		;;
    x86)
      FFMPEG_ARCH_FLAG=x86
      CROSS_PREFIX=i686-linux-android-
      CC_PREFIX=i686
      EXTRA_CFLAGS=-mno-stackrealign
      EXTRA_CONFIGURE_FLAGS=--disable-asm
  		;;
    x86_64)
      FFMPEG_ARCH_FLAG=x86_64
      CROSS_PREFIX=x86_64-linux-android-
      CC_PREFIX=x86_64
  		;;
  esac

  CC=${TOOLCHAIN_PATH}/bin/${CC_PREFIX}-linux-android${CC_ANDROID_POSTFIX}${API_LEVEL}-clang

  ./configure \
    --prefix=${BUILD_DIR}/${ARCH} \
    --disable-doc \
    --enable-cross-compile \
    --cross-prefix=${TOOLCHAIN_PATH}/bin/${CROSS_PREFIX} \
    --target-os=android \
    --cc=${CC} \
    --arch=${FFMPEG_ARCH_FLAG} \
    --extra-cflags="-O3 -fPIC $EXTRA_CFLAGS" \
    --sysroot=${SYSROOT} \
    --enable-shared \
    --disable-static \
    --disable-debug \
    --enable-small \
    --disable-runtime-cpudetect \
    --disable-programs \
    --disable-muxers \
    --disable-encoders \
    --disable-bsfs \
    --disable-pthreads \
    --disable-avdevice \
    --disable-swscale \
    --disable-network \
    --disable-postproc \
    --disable-swresample \
    --disable-avfilter \
    ${EXTRA_CONFIGURE_FLAGS}

    make clean
    make -j8
    make install

    cd ${BASE_DIR}
}

# Placing build *.so files into the /bin directory
function installLibs() {
  BUILD_SUBDIR=$1

  OUTPUT_SUBDIR=${OUTPUT_DIR}/lib/${BUILD_SUBDIR}
  CP_DIR=${BUILD_DIR}/${BUILD_SUBDIR}

  mkdir -p ${OUTPUT_SUBDIR}
  cp ${CP_DIR}/lib/*.so ${OUTPUT_SUBDIR}
}

function build() {
  ARCH=$1
  ANDROID_API=$2

  assemble ${ARCH} ${ANDROID_API}
  installLibs ${ARCH}
}

# Placing build header files into the /bin directory
# Note, there is a only one such a folder since this headers are the same for all architectures
# May not be true for different configurations though
function installHeaders() {
  cd ${BUILD_DIR}
  cd "$(ls -1 | head -n1)"
  cp -r include ${OUTPUT_DIR}
  cd ${BASE_DIR}
}

# Actual work

ensureSources

build armeabi-v7a 16
build arm64-v8a 21
build x86 16
build x86_64 21

installHeaders

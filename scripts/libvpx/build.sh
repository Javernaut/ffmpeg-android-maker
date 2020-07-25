#!/usr/bin/env bash

#Use --cpu

#Try x-android-gcc with manual CC, CXX and other

case $ANDROID_ABI in
  x86)
    EXTRA_BUILD_FLAGS="--enable-sse2 --enable-sse3 --enable-ssse3"
    ;;
  x86_64)
    EXTRA_BUILD_FLAGS="--enable-sse2 --enable-sse3 --enable-ssse3 --enable-sse4_1"
    ;;
  armeabi-v7a)
    EXTRA_BUILD_FLAGS="--enable-thumb --enable-neon --enable-neon-asm"
    ;;
  arm64-v8a)
    EXTRA_BUILD_FLAGS="--enable-thumb --enable-neon --enable-neon-asm"
    ;;
esac

CC=${FAM_CC} \
CXX=${FAM_CXX} \
AR=${FAM_AR} \
LD=${FAM_LD} \
AS=${FAM_AS} \
STRIP=${FAM_STRIP} \
NM=${FAM_NM} \
./configure \
    ${EXTRA_BUILD_FLAGS} \
    --prefix=${INSTALL_DIR} \
    --target=generic-gnu \
    --libc=${SYSROOT_PATH} \
    --enable-pic \
    --enable-realtime-only \
    --enable-install-libs \
    --enable-multithread \
    --enable-webm-io \
    --enable-libyuv \
    --enable-small \
    --enable-better-hw-compatibility \
    --enable-vp8 \
    --enable-vp9 \
    --enable-static \
    --disable-shared \
    --disable-ccache \
    --disable-debug \
    --disable-gprof \
    --disable-gcov \
    --disable-dependency-tracking \
    --disable-install-docs \
    --disable-install-bins \
    --disable-install-srcs \
    --disable-examples \
    --disable-tools \
    --disable-docs \
    --disable-unit-tests \
    --disable-decode-perf-tests \
    --disable-encode-perf-tests \
    --disable-runtime-cpu-detect  || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

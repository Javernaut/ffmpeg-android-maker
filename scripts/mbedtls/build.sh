#!/usr/bin/env bash

CMAKE_BUILD_DIR=mbedtls_build_${ANDROID_ABI}
# mbedtls authors park their source in a directory named  mbedtls-${MBEDTLS_VERSION}
# instead of root directory
cd mbedtls-${MBEDTLS_VERSION}
rm -rf ${CMAKE_BUILD_DIR}
mkdir ${CMAKE_BUILD_DIR}
cd ${CMAKE_BUILD_DIR}

${CMAKE_EXECUTABLE} .. \
 -DANDROID_PLATFORM=${ANDROID_PLATFORM} \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DENABLE_TESTING=0 

${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

export FFMPEG_MBEDTLS_ENABLED=true
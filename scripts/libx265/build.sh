#!/usr/bin/env bash

# libaom doesn't support building while being in its root directory
CMAKE_BUILD_DIR=libx265_build_${ANDROID_ABI}
rm -rf ${CMAKE_BUILD_DIR}
mkdir ${CMAKE_BUILD_DIR}
cd ${CMAKE_BUILD_DIR}

${CMAKE_EXECUTABLE} ../source \
 -DANDROID_PLATFORM=${ANDROID_PLATFORM} \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DANDROID_ARM_NEON=1 \
 -DCONFIG_PIC=1 \
 -DCONFIG_RUNTIME_CPU_DETECT=0 \
 -DENABLE_TESTS=0 \
 -DENABLE_DOCS=0 \
 -DENABLE_TESTDATA=0 \
 -DENABLE_EXAMPLES=0 \
 -DENABLE_TOOLS=0

# TODO Make it prettier
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/-lpthread/-pthread/' CMakeFiles/cli.dir/link.txt
  sed -i '' 's/-lpthread/-pthread/' CMakeFiles/x265-shared.dir/link.txt
  sed -i '' 's/-lpthread/-pthread/' CMakeFiles/x265-static.dir/link.txt
else
  sed -i 's/-lpthread/-pthread/' CMakeFiles/cli.dir/link.txt
  sed -i 's/-lpthread/-pthread/' CMakeFiles/x265-shared.dir/link.txt
  sed -i 's/-lpthread/-pthread/' CMakeFiles/x265-static.dir/link.txt
fi


${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

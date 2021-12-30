#!/usr/bin/env bash

export CC=${FAM_CC}

./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET_TRIPLE_MACHINE_ARCH}-linux-android \
    --with-sysroot=${SYSROOT_PATH} \
    --target=${TARGET} || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

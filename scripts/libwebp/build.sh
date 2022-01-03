#!/usr/bin/env bash

./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET_TRIPLE_MACHINE_ARCH}-linux-android \
    --with-sysroot=${SYSROOT_PATH} \
    --target=${TARGET} \
    CC=${FAM_CC} || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

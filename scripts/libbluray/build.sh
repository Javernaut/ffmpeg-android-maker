#!/usr/bin/env bash

LIBLURAY_ADDITIONAL_FLAGS=

CC=${FAM_CC} \
AR=${FAM_AR} \
AS=${X264_AS} \
RANLIB=${FAM_RANLIB} \
STRIP=${FAM_STRIP} \
LIBS="-lz" \
./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --enable-static \
    --with-pic \
    --without-libxml2 \
    --without-fontconfig \
    --disable-bdjava-jar \
    ${LIBLURAY_ADDITIONAL_FLAGS} || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

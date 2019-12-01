./configure \
    --prefix=${INSTALL_DIR} \
    --target=${TARGET} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --disable-shared \
    --enable-static \
    --with-pic \
    --disable-analyzer-hooks \
    --disable-decoder \
    --disable-gtktest \
    --disable-frontend \
    CC=${FAM_CC} \
    LD=${FAM_LD} \
    AR=${FAM_AR} \
    RANLIB=${FAM_RANLIB}

export FFMPEG_EXTRA_LD_FLAGS="${FFMPEG_EXTRA_LD_FLAGS} -lmp3lame"

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

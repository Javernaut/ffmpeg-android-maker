./configure \
    --prefix=${BUILD_DIR_EXTERNAL}/${ANDROID_ABI} \
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
    CC=${CC} \
    LD=${LD} \
    AR=${AR} \
    RANLIB=${RANLIB}

export FFMPEG_EXTRA_LD_FLAGS="${FFMPEG_EXTRA_LD_FLAGS} -lmp3lame"

make clean
make -j${HOST_NPROC}
make install

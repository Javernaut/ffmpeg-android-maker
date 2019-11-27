case $ANDROID_ABI in
  armeabi-v7a)
    EXTRA_BUILD_CONFIGURATION_FLAGS=--enable-thumb
    ;;
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS=--disable-asm
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS=--x86asmexe=${TOOLCHAIN_PATH}/bin/yasm
    ;;
esac

# Everything that goes below ${EXTRA_BUILD_CONFIGURATION_FLAGS} is my project-specific.
# You are free to enable/disable whatever you actually need.

# Path for prefix should come as a single argument from ffmpeg-android-maker istself
./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_BINUTILS} \
  --sysroot=${SYSROOT} \
  --cross-prefix=${CROSS_PREFIX} \
  --cc=${CC} \
  --extra-cflags="-O3 -fPIC" \
  --enable-shared \
  --disable-static \
  ${EXTRA_BUILD_CONFIGURATION_FLAGS} \
  --disable-runtime-cpudetect \
  --disable-programs \
  --disable-muxers \
  --disable-encoders \
  --disable-avdevice \
  --disable-postproc \
  --disable-swresample \
  --disable-avfilter \
  --disable-doc \
  --disable-debug \
  --disable-pthreads \
  --disable-network \
  --disable-bsfs \
  --pkg-config=$(which pkg-config)

  # Add --enable-xxx flags here

make clean
make -j${HOST_NPROC}
make install

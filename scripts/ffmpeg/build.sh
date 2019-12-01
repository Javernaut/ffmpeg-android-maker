case $ANDROID_ABI in
  armeabi-v7a)
    EXTRA_BUILD_CONFIGURATION_FLAGS=--enable-thumb
    ;;
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS=--disable-asm
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS=--x86asmexe=${FAM_YASM}
    ;;
esac

# Preparing flags for enabling requested libraries
ADDITIONAL_COMPONENTS=
for LIBARY_NAME in ${EXTERNAL_LIBRARIES[@]}
do
  ADDITIONAL_COMPONENTS+=" --enable-$LIBARY_NAME"
done

# Referencing dependencies without pkgconfig
DEP_CFLAGS="-I${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/include"
DEP_LD_FLAGS="-L${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/lib $FFMPEG_EXTRA_LD_FLAGS"

# Everything that goes below ${EXTRA_BUILD_CONFIGURATION_FLAGS} is my project-specific.
# You are free to enable/disable whatever you actually need.

./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_BINUTILS} \
  --sysroot=${SYSROOT_PATH} \
  --cross-prefix=${CROSS_PREFIX_WITH_PATH} \
  --cc=${FAM_CC} \
  --extra-cflags="-O3 -fPIC $DEP_CFLAGS" \
  --extra-ldflags="$DEP_LD_FLAGS" \
  --enable-shared \
  --disable-static \
  --pkg-config=$(which pkg-config) \
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
  $ADDITIONAL_COMPONENTS

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

#!/usr/bin/env bash

case $ANDROID_ABI in
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --disable-asm"
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --x86asmexe=${FAM_YASM}"
    ;;
esac

if [ "$FFMPEG_GPL_ENABLED" = true ] ; then
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --enable-gpl"
fi

# Preparing flags for enabling requested libraries
ADDITIONAL_COMPONENTS=
for LIBARY_NAME in ${FFMPEG_EXTERNAL_LIBRARIES[@]}
do
  ADDITIONAL_COMPONENTS+=" --enable-$LIBARY_NAME"
done

# Referencing dependencies without pkgconfig
DEP_CFLAGS="-I${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/include"
DEP_LD_FLAGS="-L${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/lib $FFMPEG_EXTRA_LD_FLAGS"

# Everything that goes below ${EXTRA_BUILD_CONFIGURATION_FLAGS} is my project-specific.
# You are free to enable/disable whatever you actually need.

SSL_EXTRA_LDFLAGS="-L${SSL_LD}/$ANDROID_ABI/lib"
SSL_EXTRA_CFLAGS="-I${SSL_LD}/$ANDROID_ABI/include"
SSL_EXTRA_CONFIG="${SSL_LD}/$ANDROID_ABI/lib/pkgconfig"

echo ${SSL_EXTRA_LDFLAGS}
echo ${SSL_EXTRA_CFLAGS}
export PKG_CONFIG_PATH=$SSL_EXTRA_CONFIG
export PATH=$PATH:$PKG_CONFIG_PATH
echo $PATH

./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_ARCH} \
  --sysroot=${SYSROOT_PATH} \
  --cc=${FAM_CC} \
  --cxx=${FAM_CXX} \
  --ld=${FAM_LD} \
  --ar=${FAM_AR} \
  --as=${FAM_CC} \
  --nm=${FAM_NM} \
  --ranlib=${FAM_RANLIB} \
  --strip=${FAM_STRIP} \
  --extra-cflags="-O3 -fPIC $DEP_CFLAGS $SSL_EXTRA_CFLAGS" \
  --extra-ldflags="$DEP_LD_FLAGS $SSL_EXTRA_LDFLAGS -DOPENSSL_API_COMPAT=0x00908000L" \
  --enable-shared \
  --pkg-config=${PKG_CONFIG_EXECUTABLE} \
  ${EXTRA_BUILD_CONFIGURATION_FLAGS} \
  --enable-small \
  --disable-ffplay \
  --disable-ffmpeg \
  --disable-ffprobe \
  --disable-avfilter \
  --disable-avdevice \
  --disable-doc \
  --disable-avdevice \
  --disable-swresample \
  --disable-postproc \
  --disable-avfilter \
  --disable-everything \
  --enable-decoder=h264 \
  --disable-gpl \
  --disable-encoders \
  --disable-hwaccels \
  --disable-muxers \
  --disable-bsfs \
  --disable-protocols \
  --disable-indevs \
  --disable-outdevs \
  --disable-devices \
  --disable-filters \
  --enable-encoder=png \
  --enable-protocol=file \
  --disable-debug \
  --disable-asm \
  $ADDITIONAL_COMPONENTS || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
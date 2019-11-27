function max() {
  [ $1 -ge $2 ] && echo "$1" || echo "$2"
}

export ANDROID_ABI=$1

if [ $ANDROID_ABI = "arm64-v8a" ] || [ $ANDROID_ABI = "x86_64" ] ; then
  export ANDROID_PLATFORM=$(max ${DESIRED_ANDROID_API_LEVEL} 21)
else
  export ANDROID_PLATFORM=${DESIRED_ANDROID_API_LEVEL}
fi

export TOOLCHAIN_PATH=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/${HOST_TAG}
export SYSROOT=${TOOLCHAIN_PATH}/sysroot

export TARGET_TRIPLE_MACHINE_BINUTILS=
TARGET_TRIPLE_MACHINE_CC=
export TARGET_TRIPLE_OS="android"

case $ANDROID_ABI in
  armeabi-v7a)
    #cc       armv7a-linux-androideabi16-clang
    #binutils arm   -linux-androideabi  -ld
    export TARGET_TRIPLE_MACHINE_BINUTILS=arm
    TARGET_TRIPLE_MACHINE_CC=armv7a
    export TARGET_TRIPLE_OS=androideabi
    ;;
  arm64-v8a)
    #cc       aarch64-linux-android21-clang
    #binutils aarch64-linux-android  -ld
    export TARGET_TRIPLE_MACHINE_BINUTILS=aarch64
    ;;
  x86)
    #cc       i686-linux-android16-clang
    #binutils i686-linux-android  -ld
    export TARGET_TRIPLE_MACHINE_BINUTILS=i686
    ;;
  x86_64)
    #cc       x86_64-linux-android21-clang
    #binutils x86_64-linux-android  -ld
    export TARGET_TRIPLE_MACHINE_BINUTILS=x86_64
    ;;
esac

# If the cc-specific variable isn't set, we fallback to binutils version
[ -z "${TARGET_TRIPLE_MACHINE_CC}" ] && TARGET_TRIPLE_MACHINE_CC=${TARGET_TRIPLE_MACHINE_BINUTILS}
export TARGET_TRIPLE_MACHINE_CC=$TARGET_TRIPLE_MACHINE_CC

# Common prefix for ld, as, etc.
export CROSS_PREFIX=${TOOLCHAIN_PATH}/bin/${TARGET_TRIPLE_MACHINE_BINUTILS}-linux-${TARGET_TRIPLE_OS}-

# The name for compiler is slightly different, so it is defined separatly.
export CC=${TOOLCHAIN_PATH}/bin/${TARGET_TRIPLE_MACHINE_CC}-linux-${TARGET_TRIPLE_OS}${ANDROID_PLATFORM}-clang

export PKG_CONFIG_LIBDIR=/Users/javernaut/Development/FFmpeg/AOM/aom_build/output/lib/pkgconfig

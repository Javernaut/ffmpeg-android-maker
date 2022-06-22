# Enable NEON for all ARM processors
set(ANDROID_ARM_NEON TRUE)

# By including this file all necessary variables that point to compiler, linker, etc.
# will be setup. Well, almost all.
# Two variables have to be set before this line though:
# ANDROID_PLATOFORM - the API level to compile against (number)
# ANDROID_ABI - the ABI of the target platform
include("$ENV{ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake")
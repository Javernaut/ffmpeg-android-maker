FROM ubuntu:20.04

# Arguments that can be overridden in 'docker build' command:
# Versions of Android SDK and NDK. The CMake is installed via NDK.
ARG VERSION_SDK=6514223
ARG VERSION_NDK=21.3.6528147
ARG VERSION_CMAKE=3.10.2.4988404

# Packages to install via apt-get
ARG VERSION_PYTHON3=3.8.2-0ubuntu2
ARG VERSION_PYTHON3_PIP=20.0.2-5ubuntu1
ARG VERSION_PYTHON3_SETUPTOOLS=45.2.0-1
ARG VERSION_PYTHON3_WHEEL=0.34.2-1
ARG VERSION_NINJA_BUILD=1.10.0-1build1
ARG VERSION_BUILD_ESSENTIAL=12.8ubuntu1
ARG VERSION_OPENJDK_8_JDK_HEADLESS=8u252-b09-1ubuntu1
ARG VERSION_CURL=7.68.0-1ubuntu2
ARG VERSION_UNZIP=6.0-25ubuntu1
ARG VERSION_BASH=5.0-6ubuntu1
ARG VERSION_NASM=2.14.02-1
ARG VERSION_PKG_CONFIG=0.29.1-0ubuntu4
ARG VERSION_MAKE=4.2.1-1.2

# Package to install via pip3
ARG VERSION_MESON=0.53.2

# The HOME variable isn't available for ENV directive (during building an image).
# So we define one manually. For alpine and ubuntu it should be '/root'
ARG HOME_TWIN=/root

# Creating mandatory environment variables
ENV ANDROID_SDK_HOME=${HOME_TWIN}/android-sdk
ENV ANDROID_NDK_HOME=${ANDROID_SDK_HOME}/ndk/${VERSION_NDK}

# Installing basic software
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3=$VERSION_PYTHON3 \
  python3-pip=$VERSION_PYTHON3_PIP \
  python3-setuptools=$VERSION_PYTHON3_SETUPTOOLS \
  python3-wheel=$VERSION_PYTHON3_WHEEL \
  ninja-build=$VERSION_NINJA_BUILD \
  build-essential=$VERSION_BUILD_ESSENTIAL \
  openjdk-8-jdk-headless=$VERSION_OPENJDK_8_JDK_HEADLESS \
  curl=$VERSION_CURL \
  unzip=$VERSION_UNZIP \
  bash=$VERSION_BASH \
  nasm=$VERSION_NASM \
  pkg-config=$VERSION_PKG_CONFIG \
  make=$VERSION_MAKE \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Meson has to be installed in a different way
RUN pip3 install meson==$VERSION_MESON

# Download the Android SDK
RUN curl https://dl.google.com/android/repository/commandlinetools-linux-${VERSION_SDK}_latest.zip --output ${HOME_TWIN}/android-sdk.zip
# Unzip it and remove the archive
RUN mkdir -p ${HOME_TWIN}/android-sdk && \
  unzip -qq ${HOME_TWIN}/android-sdk.zip -d ${HOME_TWIN}/android-sdk && \
  rm ${HOME_TWIN}/android-sdk.zip

# Installing components through the Android SDK
RUN installAndroidComponent() { yes | ${ANDROID_SDK_HOME}/tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_HOME} "$1" > /dev/null; } && \
  installAndroidComponent "ndk;${VERSION_NDK}" && \
  installAndroidComponent "cmake;${VERSION_CMAKE}"

# The command to be executed when a container is running
# Passing additional arguments to the script is done via FAM_ARGS environment variable
CMD cd /mnt/ffmpeg-android-maker && ./ffmpeg-android-maker.sh ${FAM_ARGS}

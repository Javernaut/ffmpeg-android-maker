FROM ubuntu:18.04
	
ARG DEBIAN_FRONTEND=noninteractive
ARG CMAKE_VERSION=3.10.2.4988404
ARG NDK_VERSION=21.0.6113669
ARG SDK_VERSION=6200805
ARG ANDROID_API_LEVEL=29

WORKDIR /build

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		build-essential \
		curl \
		default-jdk \
		git-core \
		libass-dev \
		libfreetype6-dev \
		libsdl2-dev \
		libtool \
		libva-dev \
		libvdpau-dev \
		libvorbis-dev \
		libxcb1-dev \
		libxcb-shm0-dev \
		libxcb-xfixes0-dev \
		pkg-config \
		texinfo \
		unzip \
		wget \
		zlib1g-dev && \
	rm -rf /var/lib/apt/lists/*
	
ENV ANDROID_SDK_HOME=/opt/android-sdk
ENV ANDROID_NDK_HOME=/opt/android-sdk/ndk/${NDK_VERSION}

RUN wget -q "https://dl.google.com/android/repository/commandlinetools-linux-${SDK_VERSION}_latest.zip" -P /tmp && \
	unzip -q -d /opt/android-sdk /tmp/commandlinetools-linux-${SDK_VERSION}_latest.zip && \
	yes Y | ${ANDROID_SDK_HOME}/tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_HOME} --licenses >/dev/null && \
	yes Y | ${ANDROID_SDK_HOME}/tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_HOME} --install "platform-tools" "platforms;android-${ANDROID_API_LEVEL}" "ndk;${NDK_VERSION}" "cmake;${CMAKE_VERSION}" && \
	rm /tmp/commandlinetools-*.zip

COPY scripts ./scripts
COPY sources ./sources
COPY ffmpeg-android-maker.sh ./

RUN chmod +x ./ffmpeg-android-maker.sh
ENTRYPOINT ["./ffmpeg-android-maker.sh"]

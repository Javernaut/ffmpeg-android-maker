# ffmpeg-android-maker

[![Build Status](https://travis-ci.org/Javernaut/ffmpeg-android-maker.svg?branch=master)](https://travis-ci.org/Javernaut/ffmpeg-android-maker)

Here is a script that downloads the source code of [FFmpeg](https://www.ffmpeg.org) library and assembles it for Android. The script produces shared libraries as well as header files. The output structure looks like this:

<img src="https://github.com/Javernaut/ffmpeg-android-maker/blob/master/images/output_structure.png" width="200">

The actual content of all this directories depends on how the FFmpeg was configured before assembling. For my purpose I enabled only *libavcodec*, *libavformat*, *libavutil* and *libswscale*, but you can set your own configuration to make the FFmpeg you need.

The version of FFmpeg here by default is **4.2.1** (but can be overridden). And the script expects to use **at least** Android NDK **r19** (*r20* also works ok).

The details of how this script is implemented are described in [this blog post](https://proandroiddev.com/a-story-about-ffmpeg-in-android-part-i-compilation-898e4a249422).

## Supported Android ABIs

* armeabi-v7a
* arm64-v8a
* x86
* x86_64

## Supported host OS

On **macOS** or **Linux** just execute the script in terminal.

It is also possible to execute this script on a **Windows** machine with [MSYS2](https://www.msys2.org). You also need to install specific packages to it: *make*, *git*, *diffutils* and *tar*. The script supports both 32-bit and 64-bit versions of Windows.

## Prerequisites

You have to define two environment variables:
* `ANDROID_SDK_HOME` - path to your Android SDK
* `ANDROID_NDK_HOME` - path to your Android NDK

Also, if you want to build *libaom*, then you have to install cmake;3.10.2.4988404 package via Android SDK.

## See it in action

Actual Android app that uses the output of the script can be found [here](https://github.com/Javernaut/WhatTheCodec).

## Features

**Setting your own FFmpeg version**. You can actually override the version of FFmpeg used by the script. See details [here](https://github.com/Javernaut/ffmpeg-android-maker/wiki/Setting-the-FFmpeg-version).

**Test your script in a cloud**. This repository has CI integration and you can use it too for your own configurations of FFmpeg. See details [here](https://github.com/Javernaut/ffmpeg-android-maker/wiki/Build-automation).

**Text relocations monitoring**. After a build you can look into stats/text-relocations.txt file. That file lists all *.so files that were built and reports if they have text relocations. If you don't see any mentioning of 'TEXTREL' in the file, you are good. Otherwise, you will see exact binaries that have this problem.   

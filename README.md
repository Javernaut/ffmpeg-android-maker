# ffmpeg-android-maker

Here is a script that downloads the source code of FFmpeg library and assembles it for Android. The script produces shared libraries as well as header files. The output structure looks like this:  
![Markdown Here logo](images/output_structure.png =250x)  
The actual content of all this directories depends on how the FFmpeg was configured before assembling. For my purpose I enabled only *libavcodec*, *libavformat* and *libavutil*, but you can set your own configuration to make the FFmpeg you need.
The version of FFmpeg here is **4.1.1**. And the script expects to use Android NDK **r19**. Starting with this versions of FFmpeg and NDK the whole process became much simpler.

## Supported architectures

* armeabi-v7a
* arm64-v8a
* x86
* x86_64

## Prerequisites

You have to define an environment variable `ANDROID_NDK_HOME` and set the correct path to your Android NDK.

## How to use

Well, just execute the script :) Examine the `output` directory after.

## Known issues:

The x86 binary doesn't have assembler optimizations, since they bring text relocations. So it may encounter certain performance issues. The x86_64 doesn't have this problem though.

## TODO:

Upload the sample project where the compiled library is actually used.

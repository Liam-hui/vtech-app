//
// Created by Fagan on 2020-08-19.
//

extern "C"
{

#include <jni.h>
#include <libavfilter/avfilter.h>

JNIEXPORT jint JNICALL
Java_com_tutk_ffmpeg_FFmpegTest_testAvfilterVersion(JNIEnv *env, jobject instance) {

    // TODO
    return avfilter_version();

}

}

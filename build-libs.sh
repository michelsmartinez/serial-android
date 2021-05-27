#!/bin/bash

if [[ -z "${ANDROID_NDK_HOME}" ]]; then
  echo "ANDROID_NDK_HOME must be set! android-ndk-r21e is confirmed to work, but other version can also work."
  echo "get it from here: https://developer.android.com/ndk/downloads"
  exit 1
fi

ARGS=$(getopt -o "dca" -l "debug,clean,archive" -n "build-libs.sh" -- "$@");

eval set -- "$ARGS";

cd libserial/src/main

JNI_ARGS="NDK_LIBS_OUT=jniLibs"
BUILD_TASK="assembleRelease"

EXPORT_AAR=1

while true; do
  case "$1" in
    -d|--debug)
      shift
      JNI_ARGS="$JNI_ARGS NDK_DEBUG=1"
      BUILD_TASK="assembleDebug"
      break;
      ;;
    -c|--clean)
      shift
      JNI_ARGS="$JNI_ARGS clean"
      break;
      ;;
    -a|--archive)
      shift
      EXPORT_AAR=1
      break;
      ;;
    --)
      shift
      break;
      ;;
  esac
done

# Remove '--'
shift

$ANDROID_NDK_HOME/build/ndk-build $JNI_ARGS

cd ../../..

if [ "$EXPORT_AAR" = "1" ]; then
  cd libserial
  ../gradlew $BUILD_TASK
  cd ..
  echo "Done, output is at libserial/build/outputs/aar"
fi

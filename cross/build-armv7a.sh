#!/bin/bash

# https://gitlab.kitware.com/cmake/cmake/issues/18739

ARCH="arm"
ABI="armeabi-v7a"
API_LEVEL="21"
BUILD_DIR="armv7a-build"

ANDROID_SDK_HOME="/home/ppetraki/Android/Sdk"
ANDROID_NDK_HOME="${ANDROID_SDK_HOME}/ndk-bundle"
TOOLCHAIN="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake"

HOST_ROOT="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64"
SYS_ROOT="${HOST_ROOT}/sysroot"
LIB_PATH="/${SYS_ROOT}/usr/lib/${ARCH}-linux-androideabi:${SYS_ROOT}/usr/lib/${ARCH}-linux-androideabi/${API_LEVEL}:${ANDROID_NDK_HOME}/platforms/android-${API_LEVEL}/arch-${ARCH}/usr/lib"
INC_PATH="${SYS_ROOT}/usr/include"

export PATH="${HOST_ROOT}/bin:${PATH}"

# XXX I not sure how much of this cmake config is actually having an impact
export CMAKE_PREFIX_PATH="${SYS_ROOT}"
export CMAKE_ROOT="${ANDROID_SDK_HOME}/Android/Sdk/cmake/3.10.2.4988404"
export CMAKE_LIBRARY_PATH=${LIB_PATH}
export CMAKE_INCLUDE_PATH=${INC_PATH}

export CFLAGS="-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN} \
  -DANDROID_STL=c++_shared \
  -DANDROID_TOOLCHAIN=clang \
  -DANDROID_PLATFORM=android-${API_LEVEL} \
  -DANDROID_ABI=${ABI}"

echo "building..."

echo "Toolchain: ${TOOLCHAIN}"

rm -rf ${BUILD_DIR}

meson setup --errorlogs  \
  --prefix=${ANDROID_NDK_HOME} \
  --includedir=${INC_PATH} \
  --libdir=${LIB_PATH} \
  --build.cmake-prefix-path=${SYS_ROOT} \
  --cross-file cross/android-armhf.ini  \
  ${BUILD_DIR} .

ninja -C ${BUILD_DIR}

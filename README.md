# Meson Android HelloWord

A proof of concept to demonstrate the current challenges in getting
meson to work with the Android NDK.

[Associated meson build issue](https://github.com/mesonbuild/meson/issues/6114)


## Usage

    cross/build-armv7a.sh

This sets up the paths and drives the meson configuration and build. You should be able
to just change `ANDROID_SDK_HOME` and go.

## Outstanding issues

- dependency() does not work at all like you would expect. It doesn't know about the cmake cross compilation environemnt
- find_library is overridden by explictly telling it where the lib paths are
- Driven with a shell script :)
- Must determine and remove variables that are not contributing to the build
- cmake subprojects don't work. -rpath $ORIGIN path is somehow not being substituted while everything
  else is configured correctly

## Output
    ppetraki@vanguard:~/Sandbox/Games/meson-android-helloworld$ ./cross/build-armv7a.sh 
    building...
    Toolchain: /home/ppetraki/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake
    The Meson build system
    Version: 0.51.999
    Source dir: /home/ppetraki/Sandbox/Games/meson-android-helloworld
    Build dir: /home/ppetraki/Sandbox/Games/meson-android-helloworld/armv7a-build
    Build type: cross build
    WARNING: Unknown options: "ANDROID_ABI, ANDROID_PLATFORM, ANDROID_STL, ANDROID_TOOLCHAIN, CMAKE_TOOLCHAIN_FILE"
    Project name: android_helloworld
    Project version: 1.0.0
    C compiler for the build machine: ccache cc (gcc 7.4.0 "cc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0")
    C linker for the build machine: GNU ld.bfd 2.30
    C++ compiler for the build machine: ccache c++ (gcc 7.4.0 "c++ (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0")
    C++ linker for the build machine: GNU ld.bfd 2.30
    C compiler for the host machine: armv7a-linux-androideabi21-clang (clang 8.0.7 "Android (5220042 based on r346389c) clang version 8.0.7 (https://android.googlesource.com/toolchain/clang b55f2d4ebfd35bf643d27dbca1bb228957008617) (https://android.googlesource.com/toolchain/llvm 3c393fe7a7e13b0fba4ac75a01aa683d7a5b11cd) (based on LLVM 8.0.7svn)")
    C linker for the host machine: GNU ld.bfd 2.27.0.20170315
    C++ compiler for the host machine: armv7a-linux-androideabi21-clang++ (clang 8.0.7 "Android (5220042 based on r346389c) clang version 8.0.7 (https://android.googlesource.com/toolchain/clang b55f2d4ebfd35bf643d27dbca1bb228957008617) (https://android.googlesource.com/toolchain/llvm 3c393fe7a7e13b0fba4ac75a01aa683d7a5b11cd) (based on LLVM 8.0.7svn)")
    C++ linker for the host machine: GNU ld.bfd 2.27.0.20170315
    Build machine cpu family: x86_64
    Build machine cpu: x86_64
    Host machine cpu family: arm
    Host machine cpu: armv7
    Target machine cpu family: arm
    Target machine cpu: armv7
    Library android found: YES
    Library log found: YES
    Build targets in project: 2
    Found ninja-1.8.2 at /usr/bin/ninja
    ninja: Entering directory `armv7a-build'                                                            
    [4/4] Linking target libandroid_helloworld_lib.so.

    ppetraki@vanguard:~/Sandbox/Games/meson-android-helloworld$ file armv7a-build/libandroid_helloworld_lib.so
    armv7a-build/libandroid_helloworld_lib.so: ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, with debug_info, not stripped

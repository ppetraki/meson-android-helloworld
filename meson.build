project('android_helloworld',
    'c', 'cpp',
    version : '1.0.0',
        default_options : ['cpp_std=c++17']
    )

cc_flags   = []
cpp_flags  = [] #['-Wfatal-errors']
link_flags = []

cc = meson.get_compiler('c')
add_project_arguments(cc.get_supported_arguments(cc_flags), language : 'c')
add_project_link_arguments(cc.get_supported_link_arguments(link_flags), language : 'c')

cpp = meson.get_compiler('cpp')
add_project_arguments(cpp.get_supported_arguments(cpp_flags), language : 'cpp')
add_project_link_arguments(cpp.get_supported_link_arguments(link_flags), language : 'cpp')

# XXX library lookup paths are not being passed through from the cross compile configuration
android_ndk = get_option('prefix')
android_lib_dir = get_option('libdir').split(':')
android_include_dir = get_option('includedir').split(':')

android_dep = cc.find_library('android', dirs : android_lib_dir)
log_dep  = cc.find_library('log', dirs : android_lib_dir)

native_app_glue_lib = static_library('native_app_glue',
  [android_ndk + '/sources/android/native_app_glue/android_native_app_glue.c'],
  include_directories: include_directories(android_ndk + '/sources/android/native_app_glue')
  )

native_app_glue_dep = declare_dependency(
  link_with: native_app_glue_lib,
  include_directories: [
    include_directories(android_ndk + '/sources/android/native_app_glue')
    ]
  )

android_helloworld_lib = shared_library('android_helloworld_lib',
  ['src/helloworld-c.cpp'],
  include_directories: include_directories('src'),
  dependencies: [android_dep, log_dep, native_app_glue_dep],
  link_args: ['-u ANativeActivity_onCreate'],
  )

android_helloworld_dep = declare_dependency(
  link_with: android_helloworld_lib,
  include_directories: include_directories('src'),
  )

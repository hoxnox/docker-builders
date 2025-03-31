{% set target_arch = "|ARCH|" %}
{% set toolchain = "/opt/{{ target_arch }}-pc-linux-musl" %}
{% set target_host = "{{ target_arch }}-pc-linux-musl" %}
{% set cc_compiler = "gcc" %}
{% set cxx_compiler = "g++" %}


[settings]
os=Linux
arch={{ target_arch }}
compiler=gcc
compiler.version=15
compiler.cppstd=gnu23
compiler.libcxx=libstdc++11
build_type=Release

[buildenv]
#PATH={{ toolchain }}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CONAN_CMAKE_FIND_ROOT_PATH={{ toolchain }}/{{ target_arch }}-pc-linux-musl/sysroot
CONAN_CMAKE_SYSTEM_NAME=Linux
#LD_LIBRARY_PATH={{ toolchain }}/{{ target_arch }}-pc-linux-musl/sysroot/lib:{{ toolchain }}/{{ target_arch }}-pc-linux-musl/lib64
CHOST={{ target_host }}
AR={{ target_host }}-ar
AS={{ target_host }}-as
RANLIB={{ target_host }}-ranlib
CC={{ target_host }}-{{ cc_compiler }}
CXX={{ target_host }}-{{ cxx_compiler }}
STRIP={{ target_host }}-strip

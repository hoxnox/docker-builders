toolchain=%TOOLCHAIN_DIR%
processor=${PROCESSOR}
target_host=$processor-pc-linux-musl
cc_compiler=gcc
cxx_compiler=g++

[settings]
os_build=Linux
arch_build=x86_64

os=Linux
arch=$processor
compiler=gcc
compiler.version=8
compiler.libcxx=libstdc++11
build_type=Release

[env]
PATH=$toolchain/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CONAN_CMAKE_FIND_ROOT_PATH=$toolchain/$processor-pc-linux-musl/sysroot
CONAN_CMAKE_SYSTEM_NAME=Linux
#LD_LIBRARY_PATH=$toolchain/$processor-pc-linux-musl/sysroot/lib:$toolchain/$processor-pc-linux-musl/lib64
CHOST=$target_host
AR=$target_host-ar
AS=$target_host-as
RANLIB=$target_host-ranlib
CC=$target_host-$cc_compiler
CXX=$target_host-$cxx_compiler
STRIP=$target_host-strip

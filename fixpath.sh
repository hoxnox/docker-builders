#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
for i in `find $DIR -mindepth 1 -maxdepth 1 -type d`
do
    if [ -f $i/cmake-toolchain.cmake.tpl ]; then
        sed "s#%TOOLCHAIN_DIR%#$i#" $i/cmake-toolchain.cmake.tpl > $i/cmake-toolchain.cmake
    fi
    if [ -f $i/conan.profile.tpl ]; then
        sed "s#%TOOLCHAIN_DIR%#$i#" $i/conan.profile.tpl > $i/conan.profile
    fi
done

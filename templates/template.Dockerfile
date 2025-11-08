FROM builder_base:0.3.0

# adding specigic compiler and making basic conan setup
COPY |ARCH|/|ARCH|-pc-linux-musl.tar.gz /opt
COPY |ARCH|/cmake-toolchain.cmake.tpl /opt/
COPY |ARCH|/conan.profile.tpl /opt/
COPY |ARCH|/qemu-|ARCH| /usr/bin/qemu-|ARCH|
COPY |ARCH|/qemu-binfmt /usr/bin/qemu-binfmt
COPY fixpath.sh /opt
RUN tar -C /opt -zxf /opt/|ARCH|-pc-linux-musl.tar.gz && rm /opt/|ARCH|-pc-linux-musl.tar.gz && \
    ln -s /opt/|ARCH|-pc-linux-musl/bin/|ARCH|-pc-linux-musl-gcc /usr/local/bin/gcc && \
    ln -s /opt/|ARCH|-pc-linux-musl/bin/|ARCH|-pc-linux-musl-g++ /usr/local/bin/g++ && \
    ln -s /opt/|ARCH|-pc-linux-musl/bin/|ARCH|-pc-linux-musl-ar /usr/local/bin/ar && \
    ln -s /opt/|ARCH|-pc-linux-musl/bin/|ARCH|-pc-linux-musl-objdump /usr/local/bin/objdump && \
    ln -s /opt/|ARCH|-pc-linux-musl/bin/|ARCH|-pc-linux-musl-strip /usr/local/bin/strip && \
    ln -s /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libc.a /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libanl.a && \
    ln -s /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libc.a /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libnsl.a && \
    ln -s /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libc.a /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/lib/libbsd.a && \
    conan profile detect && \
    echo 'core.sources:download_cache=/conan-cache' >> ~/.conan2/global.conf && \
    mv /opt/*.tpl /opt/|ARCH|-pc-linux-musl/ && \
    /opt/fixpath.sh && rm /opt/fixpath.sh && \
    cp /opt/|ARCH|-pc-linux-musl/conan.profile /root/.conan2/profiles/default && \
    touch /opt/|ARCH|-pc-linux-musl/|ARCH|-pc-linux-musl/sysroot/usr/include/execinfo.h
ENV PATH="/opt/|ARCH|-pc-linux-musl/bin:${PATH}"
COPY entrypoint /opt
RUN ["chmod", "+x", "/opt/entrypoint"]
ENTRYPOINT ["/opt/entrypoint"]

# standalone env setup
RUN conan remote remove conancenter && \
    conan remote add --insecure repo https://repo.example.com


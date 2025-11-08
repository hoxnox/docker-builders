FROM builder_base:0.3.0

# adding specigic compiler and making basic conan setup
COPY ./x86_64-pc-linux-musl.tar.gz /opt
COPY ./cmake-toolchain.cmake.tpl /opt/
COPY ./conan.profile.tpl /opt/
COPY fixpath.sh /opt
RUN tar -C /opt -zxf /opt/x86_64-pc-linux-musl.tar.gz && rm /opt/x86_64-pc-linux-musl.tar.gz && \
    ln -s /opt/x86_64-pc-linux-musl/bin/x86_64-pc-linux-musl-gcc /usr/local/bin/gcc && \
    ln -s /opt/x86_64-pc-linux-musl/bin/x86_64-pc-linux-musl-g++ /usr/local/bin/g++ && \
    ln -s /opt/x86_64-pc-linux-musl/bin/x86_64-pc-linux-musl-ar /usr/local/bin/ar && \
    ln -s /opt/x86_64-pc-linux-musl/bin/x86_64-pc-linux-musl-objdump /usr/local/bin/objdump && \
    ln -s /opt/x86_64-pc-linux-musl/bin/x86_64-pc-linux-musl-strip /usr/local/bin/strip && \
    ln -s /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libc.a /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libanl.a && \
    ln -s /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libc.a /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libnsl.a && \
    ln -s /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libc.a /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/lib/libbsd.a && \
    conan profile detect && \
    echo 'core.sources:download_cache=/conan-cache' >> ~/.conan2/global.conf && \
    mv /opt/*.tpl /opt/x86_64-pc-linux-musl/ && \
    /opt/fixpath.sh && rm /opt/fixpath.sh && \
    cp /opt/x86_64-pc-linux-musl/conan.profile /root/.conan2/profiles/default && \
    cp /opt/x86_64-pc-linux-musl/conan.profile /root/.conan2/profiles/debug && \
    sed -i 's|Release|Debug|' /root/.conan2/profiles/debug && \
    cp /opt/x86_64-pc-linux-musl/conan.profile /root/.conan2/profiles/relwithdebinfo && \
    sed -i 's|Release|RelWithDebInfo|' /root/.conan2/profiles/relwithdebinfo && \
    touch /opt/x86_64-pc-linux-musl/x86_64-pc-linux-musl/sysroot/usr/include/execinfo.h
ENV PATH="/opt/x86_64-pc-linux-musl/bin:${PATH}"
COPY entrypoint /opt
RUN ["chmod", "+x", "/opt/entrypoint"]
ENTRYPOINT ["/opt/entrypoint"]


FROM builder:base

# adding specigic compiler and making basic conan setup
COPY ${PROCESSOR}/${PROCESSOR}-pc-linux-musl.tar.gz /opt
COPY ${PROCESSOR}/cmake-toolchain.cmake.tpl /opt/
COPY ${PROCESSOR}/conan.profile.tpl /opt/
COPY ${PROCESSOR}/qemu-${PROCESSOR} /usr/bin/qemu-${PROCESSOR}
COPY ${PROCESSOR}/qemu-binfmt /usr/bin/qemu-binfmt
COPY fixpath.sh /opt
RUN tar -C /opt -zxf /opt/${PROCESSOR}-pc-linux-musl.tar.gz && rm /opt/${PROCESSOR}-pc-linux-musl.tar.gz && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-gcc /usr/local/bin/gcc && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-g++ /usr/local/bin/g++ && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-ar /usr/local/bin/ar && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-objdump /usr/local/bin/objdump && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/${PROCESSOR}-pc-linux-musl/sysroot/usr/lib/libc.a /opt/${PROCESSOR}-pc-linux-musl/${PROCESSOR}-pc-linux-musl/sysroot/usr/lib/libanl.a && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/${PROCESSOR}-pc-linux-musl/sysroot/usr/lib/libc.a /opt/${PROCESSOR}-pc-linux-musl/${PROCESSOR}-pc-linux-musl/sysroot/usr/lib/libbsd.a && \
    conan profile new --detect default && \
    conan config set storage.download_cache=/conan-cache && \
    mv /opt/*.tpl /opt/${PROCESSOR}-pc-linux-musl/ && \
    /opt/fixpath.sh && rm /opt/fixpath.sh && \
    cp /opt/${PROCESSOR}-pc-linux-musl/conan.profile /root/.conan/profiles/default && \
    touch /opt/${PROCESSOR}-pc-linux-musl/${PROCESSOR}-pc-linux-musl/sysroot/usr/include/execinfo.h
ENV PATH="/opt/${PROCESSOR}-pc-linux-musl/bin:${PATH}"
COPY entrypoint /opt
RUN ["chmod", "+x", "/opt/entrypoint"]
ENTRYPOINT ["/opt/entrypoint"]

# standalone env setup
RUN conan remote remove conancenter && \
    conan remote add repo https://repo.example.com False


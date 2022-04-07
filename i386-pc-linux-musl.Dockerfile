FROM builder:base

# adding specigic compiler and making basic conan setup
COPY i386-pc-linux-musl.tar.gz /opt
RUN tar -C /opt -zxf /opt/i386-pc-linux-musl.tar.gz && rm /opt/i386-pc-linux-musl.tar.gz && \
    ln -s /opt/i386-pc-linux-musl/bin/i386-pc-linux-musl-gcc /usr/local/bin/gcc && \
    ln -s /opt/i386-pc-linux-musl/bin/i386-pc-linux-musl-g++ /usr/local/bin/g++ && \
    conan profile new --detect default && \
    conan config set storage.download_cache=/conan-cache
COPY i386-pc-linux-musl.conan /root/.conan/profiles/default

# standalone env setup
RUN conan remote remove conancenter && \
    conan remote add devment http://conan.devment.tech False

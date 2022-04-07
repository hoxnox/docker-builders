FROM builder:base

# adding specigic compiler and making basic conan setup
COPY ${PROCESSOR}/${PROCESSOR}-pc-linux-musl.tar.gz /opt
COPY ${PROCESSOR}/cmake-toolchain.cmake.tpl /opt/
COPY ${PROCESSOR}/conan.profile.tpl /opt/
COPY fixpath.sh /opt
RUN tar -C /opt -zxf /opt/${PROCESSOR}-pc-linux-musl.tar.gz && rm /opt/${PROCESSOR}-pc-linux-musl.tar.gz && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-gcc /usr/local/bin/gcc && \
    ln -s /opt/${PROCESSOR}-pc-linux-musl/bin/${PROCESSOR}-pc-linux-musl-g++ /usr/local/bin/g++ && \
    conan profile new --detect default && \
    conan config set storage.download_cache=/conan-cache && \
    mv /opt/*.tpl /opt/${PROCESSOR}-pc-linux-musl/ && \
    /opt/fixpath.sh && rm /opt/fixpath.sh && \
    cp /opt/${PROCESSOR}-pc-linux-musl/conan.profile /root/.conan/profiles/default

# standalone env setup
RUN conan remote remove conancenter && \
    conan remote add repo https://repo.example.com False

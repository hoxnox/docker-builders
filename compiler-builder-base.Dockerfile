FROM debian:trixie-slim

RUN apt update

# basic system packages
RUN apt install -y build-essential cmake wget rsync git tmux ncurses-dev automake flex bison texinfo unzip help2man file gawk libtool libtool-bin python3

# crosstool-ng
RUN wget https://github.com/crosstool-ng/crosstool-ng/archive/refs/heads/master.tar.gz && \
    tar -xvf master.tar.gz && \
    cd crosstool-ng-master && \
    ./bootstrap; \
    ./configure && \
    make install && \
    cd .. && rm -r crosstool-ng-master

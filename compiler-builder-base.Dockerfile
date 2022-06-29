FROM alpine

# basic system packages
RUN apk add build-base                           && \
    apk add flex                                 && \
    apk add bison                                && \
    apk add texinfo                              && \
    apk add xz                                   && \
    apk add help2man                             && \
    apk add bash                                 && \
    apk add gawk                                 && \
    apk add libtool                              && \
    apk add ncurses-dev                          && \
    apk add gettext-dev                          && \
    apk add wget                                 && \
    apk add automake                             && \
    apk add autoconf                             && \
    apk add make                                 && \
    apk add cmake                                && \
    apk add git                                  && \
    apk add rsync                                && \
    apk add tmux

# python and pip
RUN apk add python3                              && \
    wget https://bootstrap.pypa.io/get-pip.py    && \
    python3 get-pip.py                           && \
    rm get-pip.py

# crosstool-ng
RUN wget https://github.com/crosstool-ng/crosstool-ng/archive/refs/heads/master.tar.gz && \
    tar -xvf master.tar.gz && \
    cd crosstool-ng-master && \
    ./bootstrap; \
    ./configure && \
    make install && \
    cd .. && rm -r crosstool-ng-master

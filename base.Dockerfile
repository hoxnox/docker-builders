FROM alpine:3.22
WORKDIR /
RUN sed -i 's|dl-cdn.alpinelinux.org/alpine|mirror.yandex.ru/mirrors/alpine|' /etc/apk/repositories
# basic system packages
RUN apk add flex                                 && \
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
    apk add patch                                && \
    apk add python3                              && \
    wget https://bootstrap.pypa.io/get-pip.py    && \
    python3 get-pip.py --break-system-packages   && \
    rm get-pip.py                                && \
    pip install --break-system-packages conan pyelftools

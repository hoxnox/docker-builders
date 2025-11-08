FROM alpine:3.22
WORKDIR /
RUN sed -i 's|dl-cdn.alpinelinux.org/alpine|mirror.yandex.ru/mirrors/alpine|' /etc/apk/repositories
RUN apk update && apk add --no-cache \
	automake     \
	autoconf     \
	cmake        \
	make         \
	libtool      \
	gcc          \
	g++          \
	xz           \
	patch        \
	wget         \
	rsync        \
	git          \
	tmux         \
	ncurses-dev  \
	flex         \
	bison        \
	texinfo      \
	unzip        \
	help2man     \
	file         \
	gawk         \
	python3      \
	bash

# crosstool-ng
RUN wget https://github.com/crosstool-ng/crosstool-ng/archive/refs/heads/master.tar.gz && \
    tar -xvf master.tar.gz && \
    cd crosstool-ng-master && \
    ./bootstrap; \
    ./configure && \
    make install && \
    cd .. && rm -r crosstool-ng-master

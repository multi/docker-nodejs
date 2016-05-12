# multi/nodejs:6.1.0

FROM alpine:edge

ENV NODE_VERSION=v6.1.0

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add libgcc libstdc++ && \
    apk add -t build-deps openssl-dev git curl make zlib-dev gcc g++ python linux-headers binutils-gold paxctl wget && \
    cd /tmp && \
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz && \
    tar zxf node-${NODE_VERSION}.tar.gz && \
    cd node-${NODE_VERSION} && \
    ./configure --prefix=/usr --shared-zlib --without-snapshot && \
    make -j$(grep -c '^processor' /proc/cpuinfo) && \
    make install && \
    paxctl -cm /usr/bin/node && \
    adduser -D -G daemon -u 1000 -h /app -s /bin/sh nodejs && \
    npm install -g npm@latest && \
    apk del --purge build-deps && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

VOLUME /app

WORKDIR /app

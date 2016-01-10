# multi/nodejs:5.4.0

FROM alpine:edge

ENV NODE_VERSION=v5.4.0 NPM_VERSION=3

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add libuv libgcc libstdc++ && \
    apk add -t build-deps openssl-dev git curl make zlib-dev gcc g++ python linux-headers binutils-gold libuv-dev paxmark && \
    cd /tmp && \
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz && \
    tar zxf node-${NODE_VERSION}.tar.gz && \
    cd node-${NODE_VERSION} && \
    ./configure --prefix=/usr --shared-zlib --shared-libuv && \
    make -j$(grep -c '^processor' /proc/cpuinfo) && \
    make install && \
    paxmark -m /usr/bin/node && \
    adduser -D -G daemon -u 1000 -h /app -s /bin/sh nodejs && \
    npm install -g npm@${NPM_VERSION} && \
    apk del --purge build-deps && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

VOLUME /app
WORKDIR /app

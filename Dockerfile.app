FROM multi/nodejs

USER root

ADD package.json bower.json /app-libs/

RUN apk add --update -t build-deps curl git binutils-gold build-base python linux-headers krb5-dev && \
    chown -R nodejs:daemon /app-libs && \
    cd /app-libs && \
    su -c 'npm install' nodejs && \
    apk del --purge build-deps && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* \
    /app/.npm /app/.node-gyp /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html \
    /usr/include

USER nodejs

EXPOSE 1337

CMD ["entrypoint.sh"]

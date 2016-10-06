FROM alpine:3.4

# set environment variables
ENV MURMUR_VERSION=1.2.17

# Add helper files
COPY ./apk/repositories /etc/apk/repositories
COPY ./murmur/murmur.ini /etc/murmur/murmur.ini
COPY ./script/docker-murmur /usr/bin/docker-murmur

RUN apk --no-cache add \
        pwgen \
        openssl \
    && adduser -SDH murmur \
    && mkdir \
        /opt \
        /var/log/murmur \
        /var/run/murmur \
    && ln -s /var/lib/murmur /etc/murmur \
    && chown -R murmur:nobody \
        /var/log/murmur \
        /var/run/murmur \
        /etc/murmur \
    && wget \
        https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 -O - |\
        bzcat -f |\
        tar -x -C /opt -f - \
    && mv /opt/murmur* /opt/murmur \
    && chmod 700 /usr/bin/docker-murmur

# Exposed port should always match what is set in /murmur/murmur.ini
EXPOSE 64738/tcp 64738/udp
WORKDIR /etc/murmur

# Add the data volume for data persistence
VOLUME ["/etc/murmur"]

# Start murmur in the foreground
ENTRYPOINT ["docker-murmur"]

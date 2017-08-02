FROM alpine:latest

# Set environment variables
ENV MURMUR_VERSION=1.2.19

# Copy project files into container
COPY ./config /etc/murmur
COPY ./docker-entrypoint.sh /usr/local/bin/

RUN apk --no-cache add \
        pwgen \
        libressl \
    && adduser -SDH murmur \
    && mkdir \
        /data \
        /opt \
        /var/run/murmur \
    && chown -R murmur:nobody \
        /var/run/murmur \
        /etc/murmur \
    && wget \
        https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 -O - |\
        bzcat -f |\
        tar -x -C /opt -f - \
    && mv /opt/murmur* /opt/murmur

# Exposed port should always match what is set in /murmur/murmur.ini
EXPOSE 64738/tcp 64738/udp

# Set the working directory
WORKDIR /etc/murmur

# Add the data volume for data persistence
VOLUME ["/data/"]

# Configure runtime container and start murmur
ENTRYPOINT ["docker-entrypoint.sh"]

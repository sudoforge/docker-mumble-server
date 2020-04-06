FROM alpine@sha256:c19173c5ada610a5989151111163d28a67368362762534d8a8121ce95cf2bd5a

# Set environment variables
ENV MUMBLE_VERSION=1.3.0

# Copy project files into container
COPY ./config /etc/murmur
COPY ./docker-entrypoint.sh /usr/local/bin/

RUN apk --no-cache add \
        pwgen \
        libressl \
    && adduser -SDH murmur \
    && mkdir -p \
        /data \
        /opt \
        /var/run/murmur \
    && chown -R murmur:nobody \
        /data \
        /etc/murmur \
        /var/run/murmur \
    && wget \
        https://github.com/mumble-voip/mumble/releases/download/${MUMBLE_VERSION}/murmur-static_x86-${MUMBLE_VERSION}.tar.bz2 -O - |\
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

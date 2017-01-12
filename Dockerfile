FROM alpine:3.5

# Set environment variables
ENV MURMUR_VERSION=1.2.18

# Copy project files into container
COPY ./murmur /etc/murmur
COPY ./script/docker-murmur /usr/bin/docker-murmur

RUN apk --no-cache add \
        pwgen \
        openssl \
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
    && mv /opt/murmur* /opt/murmur \
    && chmod 700 /usr/bin/docker-murmur

# Exposed port should always match what is set in /murmur/murmur.ini
EXPOSE 64738/tcp 64738/udp

# Set the working directory
WORKDIR /etc/murmur

# Add the data volume for data persistence
VOLUME ["/data/"]

# Configure runtime container and start murmur
ENTRYPOINT ["/usr/bin/docker-murmur"]

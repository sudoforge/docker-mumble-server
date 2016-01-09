FROM alpine:3.2

# Add helper files
COPY ./apk/repositories /etc/apk/repositories
COPY ./murmur/murmur.ini /etc/murmur.ini
COPY ./script/start /start

RUN apk --update add murmur pwgen \
    && rm -rf /var/cache/apk/* \
    && chmod 700 /start

# Exposed port should always match what is set in /murmur/murmur.ini
EXPOSE 64738

# Add the data volume for data persistence
VOLUME ["/data"]

# Start murmur in the foreground
ENTRYPOINT ["/start"]

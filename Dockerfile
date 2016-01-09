FROM alpine:3.2

# Add repositories
ADD ./apk/repositories /etc/apk/repositories

# Add murmur and pwgen
RUN apk --update add murmur pwgen; rm -rf /var/cache/apk/*

# Add murmur.ini
ADD ./murmur/murmur.ini /etc/murmur.ini

# Add the start script and delete pwgen (no longer needed)
#
# Notes:
# 1. SuperUser's password is output to the console in this step
# 2. The script deletes itself on completion
ADD ./script/start /start
RUN chmod 700 /start

# Expose the port
# This should always match the port set in /murmur/murmur.ini
EXPOSE 64738

# Add the data volume for data persistence
VOLUME ["/data"]

# Start murmur in the foreground
ENTRYPOINT ["/start"]

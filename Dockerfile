FROM gliderlabs/alpine:3.2

# Add repositories
ADD ./apk/repositories /etc/apk/repositories

# Add murmur and pwgen
RUN apk --update add murmur pwgen

# Add murmur.ini
ADD ./murmur/murmur.ini /etc/murmur.ini

# Add the setup script
#
# Notes:
# 1. SuperUser's password is output to the console in this step
# 2. The script deletes itself on completion
ADD ./setup /setup
RUN chmod 700 /setup
RUN ./setup

# Expose the port
# This should always match the port set in /murmur/murmur.ini
EXPOSE 64738

# Add the data volume for data persistence
VOLUME ["/data"]

# Start murmur in the foreground
ENTRYPOINT ["/usr/bin/murmurd", "-fg"]

# SPDX-License-Identifier: Apache-2.0
# Copyright 2015-2022 Benjamin Denhartog <sudoforge.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Created: 2021-01-28T23:19:38.219326874Z
FROM alpine@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930

# Set environment variables
ENV MUMBLE_VERSION=1.3.4

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

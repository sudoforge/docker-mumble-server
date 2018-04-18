FROM fedora:latest
MAINTAINER Containerly <https://github.com/containerly>

RUN dnf makecache && \
    dnf upgrade -y && \
    dnf install -y createrepo && \
    dnf clean all

ENTRYPOINT ["/usr/bin/createrepo"]

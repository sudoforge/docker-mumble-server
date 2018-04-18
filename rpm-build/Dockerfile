FROM fedora:latest
MAINTAINER Containerly <https://github.com/containerly>

RUN dnf makecache && \
    dnf upgrade -y && \
    dnf install -y make rpm-build && \
    dnf clean all

ENTRYPOINT ["/usr/bin/rpmbuild"]

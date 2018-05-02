FROM fedora:latest
MAINTAINER https://github.com/sudoforge

RUN dnf makecache && \
    dnf upgrade -y && \
    dnf install -y make rpm-build && \
    dnf clean all

ENTRYPOINT ["/usr/bin/rpmbuild"]

#!/usr/bin/env sh

docker build \
  --tag "sudoforge/mumble-server:${GITHUB_SHA}" \
  --label "build-id=${GITHUB_SHA}" \
  mumble-server

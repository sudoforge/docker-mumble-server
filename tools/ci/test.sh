#!/usr/bin/env bash
#
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

set +e

_range=10

# Start the container
docker run -d -P "sudoforge/mumble-server:${GITHUB_SHA}" 1> /dev/null

# Get the container ID, but only if the status is "running"
for i in {1.."$_range"}; do
  CONTAINER_ID=$(docker ps -f "label=build-id=${GITHUB_SHA}" -f "status=running" -q)

  # Circuit break if we have a result
  [ "$CONTAINER_ID" != "" ] && break

  sleep 1

  # If we've reached our maximum tries, then exit out
  if [ "$i" == "${_range}" ]; then
    echo "FATAL: unable to determine container id, container may not be running"
    exit 1
  fi
done

# Clean up by removing the container
trap 'docker rm -f "$CONTAINER_ID" > /dev/null 2>&1; trap - EXIT; exit' EXIT INT HUP TERM

# Check for a running mumble-server process for up to n times, defined by _range
for i in {1.."$_range"}; do
  if docker exec "$CONTAINER_ID" /bin/ps | grep murmur; then
    break
  fi

  sleep 1
  [ "$i" == "${_range}" ] && echo "FATAL: mumble-server is not running in the container" && exit 1
done

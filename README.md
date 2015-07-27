# docker-murmur

## Getting started

__Murmur__ is the server that __Mumble__ clients to connect to. You can read more about Murmur and Mumble on [Wikipedia][wikipedia-mumble].

This guide assumes that you already have [Docker][docker] installed.

### Clone this repository
You'll probably want to clone this repository (or download it some other way). This will create the `docker-murmur` folder in your current directory, and clone the repository within that:

    $ git clone git@github.com:bddenhartog/docker-murmur.git

### Build the image locally
Next, you'll need to build the base image locally as it is not maintained on DockerHub (because the `data` directory is shared from all containers spawned from the base image, it wouldn't make sense to share that base image -- in other words, I wouldn't recommend putting your image on DockerHub).

Assuming you haven't moved directories yet, let's build an image with the `docker-murmur` tag, so that we can easily reference it.

    $ cd docker-murmur
    $ docker build -t docker-murmur .

### Create a container
Now that you have a "base image", let's get a container up and running.

    $ docker run -d -p YOUR_LOCAL_PORT:64738 --name YOUR_CONTAINER_NAME docker-murmur

You should change these things:

1. *YOUR_LOCAL_PORT* should be replaced with whatever local port you want to have forwarded to the container's port.
2. *YOUR_CONTAINER_NAME* should be replaced with whatever name you want for your container, like "_my-murmur-container_".

**[ ! ] IMPORTANT**
There's no real need to, but if you wanted to run Murmur on a different port within the container (it runs on 64738 by default), then you should make sure you reference that port in the `docker run` command above. You also need to change it in these two files:

1. `/Dockerfile`, on line 19.
2. `/murmur/murmur.ini`, on line 91.

## Updating
I'll always make an effort to update this if things become out of date, so a simple `git pull` should get you the latest working version of things! That said, I don't foresee *needing* to update this for quite some time.

## Special Thanks
I wouldn't have been able to create this without the previous work of these fantastic folks:

- @gliderlabs, and their awesome ~5MB docker image based off of Alpine Linux, which you can [check out on github][gliderlabs/docker-alpine].
- @overshard, who previously maintained his (now deprecated) [docker-mumble][docker-mumble] repository.
- The wonderful teams behind git and docker.

## Notes
The image built from this Dockerfile uses @gliderlab's [docker-alpine][gliderlabs/docker-alpine] image, which is based off of [Alpine Linux][alpine-linux]. While I was building this, I ran into issues with the single Alpine Linux repository that is included in their image by default (basically, dl-4 was down so `apk` couldn't update or install anything). To fix that, I've added the custom repository sources (in `/apk/repositories`), which is just official mirrors. This replaces the single repository in the [docker-alpine][gliderlabs/docker-alpine], so that we can actually hit a repository server and install packages.

All that said, if `apk` hangs on one of the mirrors, don't fret. It'll pull through. During development, 3 and 4 hung endlessly so I just removed them. You'll notice that they are in the repo now; just remove mirrors if you notice them constantly failing and the delay annoys you.

## License
Licensed under MIT. [View License][license]

[wikipedia-mumble]: https://en.wikipedia.org/wiki/Mumble_(software) "Mumble on Wikipedia"
[docker]: https://www.docker.com/ "Docker"
[gliderlabs]: https://github.com/gliderlabs "Glider Labs"
[gliderlabs/docker-alpine]: https://github.com/gliderlabs/docker-alpine "gliderlabs/docker-alpine"
[docker-mumble]: https://github.com/overshard/docker-mumble "overshard/docker-mumble"
[alpine-linux]: http://alpinelinux.org/ "Alpine Linux"
[license]: https://github.com/bddenhartog/docker-murmur/blob/master/LICENSE.md "View License"

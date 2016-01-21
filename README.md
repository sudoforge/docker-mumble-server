[![Build Status](https://travis-ci.org/bddenhartog/docker-murmur.svg?branch=master)](https://travis-ci.org/bddenhartog/docker-murmur)
[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/bddenhartog/docker-murmur/latest.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/bddenhartog/docker-murmur.svg?style=flat)](https://hub.docker.com/r/bddenhartog/docker-murmur/)

# docker-murmur

**Mumble** is a VOIP application which allows users to talk to each other via
the same server. It uses a client-server architecture, and encrypts all
communication to ensure user privacy. **Murmur** is the server that Mumble
clients to connect to. [Learn More][1].

`docker-murmur` enables you to easily run multiple (lightweight) murmur
instances on the same host.

```bash
$ docker images
REPOSITORY                     TAG         VIRTUAL SIZE
bddenhartog/docker-murmur      latest      40.18 MB
```

## Getting started

This guide assumes that you already have [Docker][2] installed.

### **Option 1**: Pull the official image

It's easiest to get going if you pull the image from the [official hub repo][4].

```bash
docker pull bddenhartog/docker-murmur
```

Next, you should [create a container](#create-a-container).

### **Option 2**: Install from source

You can also build the image locally.

#### Clone this repository

You'll probably want to clone this repository (or download it some other way).
This will create the `docker-murmur` folder in your current directory, and clone
the repository within that:

```bash
git clone https://github.com/bddenhartog/docker-murmur.git
```

#### Build the image locally

Next, you'll need to build the base image locally as it is not maintained on
Docker Hub (because the `data` directory is shared from all containers spawned
from the base image, it wouldn't make sense to share that base image -- in other
words, I wouldn't recommend putting your image on DockerHub).

Assuming you haven't moved directories yet, let's build an image with the
`docker-murmur` tag, so that we can easily reference it.

```bash
cd docker-murmur
docker build -t docker-murmur .
```

Next, you should [create a container](#create-a-container).

### Create a container

Now that you have a "base image", let's get a container up and running.

```bash
docker run -d -p <HOST-PORT>:64738 --name <CONTAINER-NAME> <IMAGE-NAME>
```

| Original       | Replace with                           |
| -------------- | -------------------------------------- |
| HOST-POST      | An available port on the host machine  |
| CONTAINER-NAME | Desired name for the container         |
| IMAGE-NAME     | The base image's name                  |

You can additionally pass in `-e SERVER_PASSWORD='<your-password-here>'` to
configure the murmur instance with a password.

### Logging in as SuperUser

Each new container will have a unique password for `SuperUser`, the
administrative user for your Murmur server. To get this password, simply view
the container logs. It is recommended that you save SuperUser's password
somewhere safe for each container.

```shell
$ docker logs <CONTAINER-NAME>

...
=============================================

[ ! ] SUPERUSER_PASSWORD: <generated-pw>

=============================================
```

## Updating

To update, you should perform the following steps _in order_:

1.  Stop and kill all of your active `docker-murmur` containers.
2.  Enter the directory on your host machine for the repo.
3.  Run `git pull` to receive the latest changes.
4.  Follow the installation instructions ()

## License

Licensed under MIT. [View License][3].

[1]: https://en.wikipedia.org/wiki/Mumble_(software) "Wikipedia - Mumble (software)"
[2]: https://www.docker.com/ "Docker"
[3]: LICENSE.md "View License"
[4]: https://hub.docker.com/r/bddenhartog/docker-murmur/ "bddenhartog/docker-murmur"

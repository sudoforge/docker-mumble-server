[![Build Status](https://travis-ci.org/bddenhartog/docker-murmur.svg?branch=master)](https://travis-ci.org/bddenhartog/docker-murmur)
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

### Configure Container
Each variable can be set by passing it as an environment variable (`-e`) to the server.

For example: `-e MUMBLE_SERVERPASSWORD=somereallysecretpassword`.

Here is a list of all options:

|Variable|Setting|
|--------|-------|
|`MUMBLE_SERVERPASSWORD`|[serverpassword](https://wiki.mumble.info/wiki/Murmur.ini#serverpassword)|
|`MUMBLE_DEFAULTCHANNEL`|[defaultchannel](https://wiki.mumble.info/wiki/Murmur.ini#defaultchannel)|
|`MUMBLE_REGISTER_HOSTNAME`|[registerHostname](https://wiki.mumble.info/wiki/Murmur.ini#registerHostname)|
|`MUMBLE_REGISTER_PASSWORD`|[registerpassword](https://wiki.mumble.info/wiki/Murmur.ini#registerPassword)|
|`MUMBLE_REGISTER_URL`|[registerurl](https://wiki.mumble.info/wiki/Murmur.ini#registerUrl)|
|`MUMBLE_REGISTER_NAME`|[registername](https://wiki.mumble.info/wiki/Murmur.ini#registerName)|
|`MUMBLE_USERLIMIT`|[users](https://wiki.mumble.info/wiki/Murmur.ini#users)|
|`MUMBLE_USERSPERCHANNEL`|[usersperchannel](https://wiki.mumble.info/wiki/Murmur.ini#usersperchannel) (disables global user limit)|
|`MUMBLE_TEXTLENGTH`|[textmessagelength](https://wiki.mumble.info/wiki/Murmur.ini#textmessagelength)|
|`MUMBLE_IMAGELENGTH`|[imagemessagelength](https://wiki.mumble.info/wiki/Murmur.ini#imagemessagelength)|
|`MUMBLE_ALLOWHTML`|[allowhtml](https://wiki.mumble.info/wiki/Murmur.ini#allowhtml) (Is disabled by default and by setting the variable it'll enabled)|
|`MUMBLE_ENABLESSL`|This is a special variable. When you set it you have to provide a key.pem and a cert.pem in your docker volume.|

To customize the welcome text, add the contents to `welcome.txt` and mount that into the container at `/data/welcome.txt`. Be sure to avoid double quotes within the file!

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

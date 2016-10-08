[![Build Status](https://travis-ci.org/bddenhartog/docker-murmur.svg?branch=master)](https://travis-ci.org/bddenhartog/docker-murmur) [![Alpine v3.4](https://img.shields.io/badge/alpine-3.4-green.svg?maxAge=2592000)]() [![Murmur v1.2.17](https://img.shields.io/badge/murmur-1,2,17-green.svg?maxAge=2592000)]() [![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000)](https://github.com/bddenhartog/docker-murmur/blob/master/LICENSE.md) [![Docker Pulls](https://img.shields.io/docker/pulls/bddenhartog/docker-murmur.svg)](https://hub.docker.com/r/bddenhartog/docker-murmur/) [![Docker Stars](https://img.shields.io/docker/stars/bddenhartog/docker-murmur.svg?maxAge=2592000)](https://hub.docker.com/r/bddenhartog/docker-murmur/)

# docker-murmur

**Mumble** is a VOIP application which allows users to talk to each other via
the same server. It uses a client-server architecture, and encrypts all
communication to ensure user privacy. **Murmur** is the server that Mumble
clients to connect to. [Learn More][1].

`docker-murmur` enables you to easily run multiple (lightweight) murmur
instances on the same host.

## Getting started

This guide assumes that you already have [Docker][2] installed.

### Pull the official image

It's easiest to get going if you pull the image from the [Docker Hub][4]. The 
image is built automatically from this repository.

```
$ docker pull bddenhartog/docker-murmur
```

> #### Alternatively, install from source.
> ```
> $ git clone https://github.com/bddenhartog/docker-murmur.git
> $ cd docker-murmur
> $ docker build -t bddenhartog/docker-murmur .
> ```
>
> Windows users should run `git config --global core.autocrlf false` prior to 
> cloning to avoid line ending issues with the files that are added to the 
> image.

### Create a container

Now that you have the image built, it's time to get a container up and running.

```
$ docker run -d \
    -p 64738:64738 \
    --name murmur-001 \
    bddenhartog/docker-murmur
```

### Configuration options
The following variables can be passed into the container (when you execute 
`docker run`) to change various confirguation options.

For example:

```
$ docker run -d \
    -p 64738:64738 \
    -e MUMBLE_SERVERPASSWORD='superSecretPasswordHere' \
    bddenhartog/docker-murmur
```

Here is a list of all options:

| Environment Variable | Default Value | Documentation |
| -------------------- | ------------- | ------------- |
| `MUMBLE_SERVERPASSWORD` | `NONE` | [https://wiki.mumble.info/wiki/Murmur.ini#serverpassword]() |
| `MUMBLE_DEFAULTCHANNEL` | `NONE` | [https://wiki.mumble.info/wiki/Murmur.ini#defaultchannel]() |
| `MUMBLE_REGISTERHOSTNAME` | `NONE` | [https://wiki.mumble.info/wiki/Murmur.ini#registerHostname]() |
| `MUMBLE_REGISTERPASSWORD` | `NONE` | [https://wiki.mumble.info/wiki/Murmur.ini#registerPassword]() |
| `MUMBLE_REGISTERURL` | `NONE` | [https://wiki.mumble.info/wiki/Murmur.ini#registerUrl]() |
| `MUMBLE_REGISTERNAME` | `Root` | [https://wiki.mumble.info/wiki/Murmur.ini#registerName]() |
| `MUMBLE_USERLIMIT` | `50` | [https://wiki.mumble.info/wiki/Murmur.ini#users]() |
| `MUMBLE_USERSPERCHANNEL` | `NO LIMIT` | [https://wiki.mumble.info/wiki/Murmur.ini#usersperchannel]() |
| `MUMBLE_TEXTLENGTH` | `5000` | [https://wiki.mumble.info/wiki/Murmur.ini#textmessagelength]() |
| `MUMBLE_IMAGELENGTH` |`131072` | [https://wiki.mumble.info/wiki/Murmur.ini#imagemessagelength]() |
| `MUMBLE_ALLOWHTML` | `TRUE` | [https://wiki.mumble.info/wiki/Murmur.ini#allowhtml]() |
| `MUMBLE_ENABLESSL` | `DISABLED` | When set to `1`, SSL is enabled with `/data/cert.pem` and `/data/key.pem`. |

To customize the welcome text, add the contents to `welcome.txt` and mount that into the container at `/data/welcome.txt`. Be sure to avoid double quotes within the file!

### Logging in as SuperUser

Each new container will have a unique password automatically generated for 
`SuperUser`, the administrative user for the Murmur server. To get this 
password, simply view the container logs. It is recommended that you save 
the password somewhere safe for each container.

```
$ docker logs <CONTAINER-NAME>

...
=============================================

[ ! ] SUPERUSER_PASSWORD: <generated-pw>

=============================================
...
```

## Updating

To update your image locally, simply run `docker pull bddenhartog/docker-murmur`.

## License

Licensed under MIT. [View License][3].

[1]: https://en.wikipedia.org/wiki/Mumble_(software) "Wikipedia - Mumble (software)"
[2]: https://www.docker.com/ "Docker"
[3]: LICENSE.md "View License"
[4]: https://hub.docker.com/r/bddenhartog/docker-murmur/ "bddenhartog/docker-murmur"

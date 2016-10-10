# docker-murmur [![Build Status](https://travis-ci.org/bddenhartog/docker-murmur.svg?branch=master)](https://travis-ci.org/bddenhartog/docker-murmur) [![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000)][repo-license]

[![Alpine v3.4](https://img.shields.io/badge/alpine-3.4-green.svg?maxAge=2592000)][repo-url] [![Murmur v1.2.17](https://img.shields.io/badge/murmur-1.2.17-green.svg?maxAge=2592000)][repo-url] [![Docker Pulls](https://img.shields.io/docker/pulls/bddenhartog/docker-murmur.svg)][docker-hub-repo-url] [![Docker Stars](https://img.shields.io/docker/stars/bddenhartog/docker-murmur.svg)][docker-hub-repo-url]

**Mumble** is a VOIP application which allows users to talk to each other via
the same server. It uses a client-server architecture, and encrypts all
communication to ensure user privacy. **Murmur** is the server that Mumble
clients to connect to. [Learn More][vendor-mumble].

`docker-murmur` enables you to easily run multiple (lightweight) murmur
instances on the same host.

## Getting started

This guide assumes that you already have [Docker][docker-install-docs] installed.

### Pull the official image

It's easiest to get going if you pull the image from the [Docker Hub][docker-hub-repo-url]. The
image is built automatically from this repository.

```text
docker pull bddenhartog/docker-murmur
```

> #### Alternatively, you can build the image from source
> ```text
> git clone https://github.com/bddenhartog/docker-murmur.git
> cd docker-murmur
> docker build -t bddenhartog/docker-murmur .
> ```
>
> Windows users should run `git config --global core.autocrlf false` prior to
> cloning to avoid line ending issues with the files that are added to the
> image when executing `docker build`.

### Create a container

Now that you have the image built, it's time to get a container up and running.

```text
docker run -d \
    -p 64738:64738 \
    --name murmur-001 \
    bddenhartog/docker-murmur
```

### Configuration options

The following variables can be passed into the container (when you execute
`docker run`) to change various confirguation options.

For example:

```text
docker run -d \
    -p 64738:64738 \
    -e MUMBLE_SERVERPASSWORD='superSecretPasswordHere' \
    --name murmur-001 \
    bddenhartog/docker-murmur
```

Here is a list of all options:

| Environment Variable | Default Value | Documentation |
| -------------------- | ------------- | ------------- |
| `MUMBLE_SERVERPASSWORD` | `NONE` | <https://wiki.mumble.info/wiki/Murmur.ini#serverpassword> |
| `MUMBLE_DEFAULTCHANNEL` | `NONE` | <https://wiki.mumble.info/wiki/Murmur.ini#defaultchannel> |
| `MUMBLE_REGISTERHOSTNAME` | `NONE` | <https://wiki.mumble.info/wiki/Murmur.ini#registerHostname> |
| `MUMBLE_REGISTERPASSWORD` | `NONE` | <https://wiki.mumble.info/wiki/Murmur.ini#registerPassword> |
| `MUMBLE_REGISTERURL` | `NONE` | <https://wiki.mumble.info/wiki/Murmur.ini#registerUrl> |
| `MUMBLE_REGISTERNAME` | `Root` | <https://wiki.mumble.info/wiki/Murmur.ini#registerName> |
| `MUMBLE_USERLIMIT` | `50` | <https://wiki.mumble.info/wiki/Murmur.ini#users> |
| `MUMBLE_USERSPERCHANNEL` | `NO LIMIT` | <https://wiki.mumble.info/wiki/Murmur.ini#usersperchannel> |
| `MUMBLE_TEXTLENGTH` | `5000` | <https://wiki.mumble.info/wiki/Murmur.ini#textmessagelength> |
| `MUMBLE_IMAGELENGTH` |`131072` | <https://wiki.mumble.info/wiki/Murmur.ini#imagemessagelength> |
| `MUMBLE_ALLOWHTML` | `TRUE` | <https://wiki.mumble.info/wiki/Murmur.ini#allowhtml> |
| `MUMBLE_ENABLESSL` | `DISABLED` | When set to `1`, SSL is enabled with `/data/cert.pem` and `/data/key.pem`. |

To customize the welcome text, add the contents to `welcome.txt` and mount that into the container at `/data/welcome.txt`. Be sure to avoid double quotes within the file!

### Logging in as SuperUser

Each new container will have a unique password automatically generated for
`SuperUser`, the administrative user for the Murmur server. To get this
password, simply view the container logs. It is recommended that you save
the password somewhere safe for each container.

```text
$ docker logs murmur-001
>
> =============================================
>
> [ ! ] SUPERUSER_PASSWORD: <generated-pw>
>
> =============================================
```

## Updating

To update your image locally, simply run `docker pull bddenhartog/docker-murmur`.

## License

Licensed under MIT. [View License][repo-license].

---

[![Analytics](https://ga-beacon.appspot.com/UA-85446052-1/github-landing-page?flat)][repo-url]

[repo-url]: https://www.github.com/bddenhartog/docker-murmur
[repo-license]: https://github.com/bddenhartog/docker-murmur/blob/master/LICENSE.md "View License"
[vendor-mumble]: http://wiki.mumble.info/wiki/Main_Page "Learn About Mumble"
[docker-install-docs]: https://docs.docker.com/engine/installation/ "Docker Installation Docs"
[docker-hub-repo-url]: https://hub.docker.com/r/bddenhartog/docker-murmur/ "View on DockerHub"

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

Here is a list of all options supported through environment variables:

| Environment Variable | Default Value | Details |
| -------------------- | ------------- | ------- |
| `MUMBLE_ICE` | `tcp -h 127.0.0.1 -p 6502` | [Murmur.ini::ice][mdoc-ice] |
| `MUMBLE_ICESECRETREAD` | `---` | [Murmur.ini::icesecretread][mdoc-group-icesecret] |
| `MUMBLE_ICESECRETWRITE` | `---` | [Murmur.ini::icesecretwrite][mdoc-group-icesecret] |
| `MUMBLE_AUTOBANATTEMPTS` | `10`    | [Murmur.ini::autobanAttempts][mdoc-group-autoban] |
| `MUMBLE_AUTOBANTIMEFRAME` | `120` | [Murmur.ini::autobanAttempts][mdoc-group-autoban] |
| `MUMBLE_AUTOBANTIME` | `300` | [Murmur.ini::autobanAttempts][mdoc-group-autoban] |
| `MUMBLE_SERVERPASSWORD`| `---` | [Murmur.ini::serverpassword][mdoc-serverpassword] |
| `MUMBLE_OBFUSCATE` | `false` | [Murmur.ini::obfuscate][mdoc-obfuscate] |
| `MUMBLE_SENDVERSION` | `false`| [Murmur.ini::sendversion][mdoc-sendversion] |
| `MUMBLE_LEGACYPASSWORDHASH` | `false` | [Murmur.ini::legacyPasswordHash][mdoc-legacyPasswordHash] |
| `MUMBLE_KDFITERATIONS` | `-1`| [Murmur.ini::kdfIterations][mdoc-kdfIterations] |
| `MUMBLE_ALLOWPING` | `true`| [Murmur.ini::allowping][mdoc-allowping] |
| `MUMBLE_BANDWIDTH` | `7200`| [Murmur.ini::bandwidth][mdoc-bandwidth] |
| `MUMBLE_TIMEOUT` | `30`| [Murmur.ini::timeout][mdoc-timeout] |
| `MUMBLE_USERS` | `100` | [Murmur.ini::users][mdoc-users] |
| `MUMBLE_USERSPERCHANNEL` | `0` | [Murmur.ini::usersperchannel][mdoc-usersperchannel] |
| `MUMBLE_USERNAME`| `[-=\\w\\[\\]\\{\\}\\(\\)\\@\\|\\.]+` | [Murmur.ini::username][mdoc-group-channelusername] |
| `MUMBLE_CHANNELNAME` | `[ \\-=\\w\\#\\[\\]\\{\\}\\(\\)\\@\\|]+` | [Murmur.ini::channelname][mdoc-group-channelusername] |
| `MUMBLE_DEFAULTCHANNEL`| `---` | [Murmur.ini::defaultchannel][mdoc-defaultchannel] |
| `MUMBLE_REMEMBERCHANNEL` | `true`| [Murmur.ini::rememberchannel][mdoc-rememberchannel] |
| `MUMBLE_TEXTMESSAGELENGTH`| `5000`| [Murmur.ini::textmessagelength][mdoc-textmessagelength] |
| `MUMBLE_IMAGEMESSAGELENGTH` |`131072` | [Murmur.ini::imagemessagelength][mdoc-imagemessagelength] |
| `MUMBLE_ALLOWHTML` | `true`| [Murmur.ini::allowhtml][mdoc-allowhtml] |
| `MUMBLE_OPUSTHRESHOLD` | `100` | [Murmur.ini::opusthreshold][mdoc-opusthreshold] |
| `MUMBLE_REGISTERHOSTNAME` | `---` | [Murmur.ini::registerHostname][mdoc-registerHostname] |
| `MUMBLE_REGISTERPASSWORD` | `---` | [Murmur.ini::registerPassword][mdoc-registerPassword] |
| `MUMBLE_REGISTERURL` | `---` | [Murmur.ini::registerUrl][mdoc-registerUrl] |
| `MUMBLE_REGISTERNAME`| `---`| [Murmur.ini::registerName][mdoc-registerName] |
| `MUMBLE_SUGGESTVERSION`| `false` | [Murmur.ini::suggestVersion][mdoc-suggestVersion] |
| `MUMBLE_SUGGESTPOSITIONAL`| `---` | [Murmur.ini::suggestPositional][mdoc-suggestPositional] |
| `MUMBLE_SUGGESTPUSHTOTALK`| `---` | [Murmur.ini::suggestPushToTalk][mdoc-suggestPushToTalk] |
| `MUMBLE_ENABLESSL` | `0` | See [SSL Certificates](#ssl-certificates-murmurinissl) below |
| `MUMBLE_SSLPASSPHRASE` | `---` | See [SSL Certificates](#ssl-certificates-murmurinissl) below |
| `SUPERUSER_PASSWORD` | `---` | If not defined, a password will be auto-generated. |

### Custom welcome text ([Murmur.ini::welcometext][mdoc-welcometext])

To customize the welcome text, add the contents to `welcome.txt` and mount that
into the container at `/data/welcome.txt`. Special characters are escaped
automatically, but you may want to double check

### SSL Certificates ([Murmur.ini::SSL][mdoc-sslcertkey])

SSL certificate settings are handled a bit differently, to simplify running
this container. If `MUMBLE_ENABLESSL` is set to `1`, SSL is automatically
enabled, as long as you have mounted a certificate and key at the
following locations:

- SSL certificate should be mounted at `/data/cert.pem`

  - If your certificate is signed by an authority that uses a sub-signed or
    "intermediate" certificate, you should either bundle that with your
    certificate, or mount it in separately at `/data/intermediate.pem` - this
    will be automatically detected.

- SSL key should be mounted at `/data/key.pem`

  - If the key has a passphrase, you should define the environment variable
    `MUMBLE_SSLPASSPHRASE` with the passphrase. This variable does not have
    any effect if you have not mounted a key *and* enabled SSL.

### Logging in as SuperUser

If the environment variable `SUPERUSER_PASSWORD` is not defined when creating
the container, a password will be automatically generated. To view the password
for any container at any time, look at the container's logs. As an example, to
view the SuperUser password is for an instance running in a container
named `murmur-001`:

```text
$ docker logs murmur-001 2>&1 | grep SUPERUSER_PASSWORD
> SUPERUSER_PASSWORD: <value>
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
[mdoc-ice]: https://wiki.mumble.info/wiki/Murmur.ini#ice
[mdoc-group-icesecret]: https://wiki.mumble.info/wiki/Murmur.ini#icesecretread_and_icesecretwrite
[mdoc-group-autoban]: https://wiki.mumble.info/wiki/Murmur.ini#autobanAttempts.2C_autobanTimeframe_and_autobanTime
[mdoc-serverpassword]: https://wiki.mumble.info/wiki/Murmur.ini#serverpassword
[mdoc-obfuscate]: https://wiki.mumble.info/wiki/Murmur.ini#obfuscate
[mdoc-sendversion]: https://wiki.mumble.info/wiki/Murmur.ini#sendversion
[mdoc-legacyPasswordHash]: https://wiki.mumble.info/wiki/Murmur.ini#legacyPasswordHash
[mdoc-kdfiterations]: https://wiki.mumble.info/wiki/Murmur.ini#kdfIterations
[mdoc-allowping]: https://wiki.mumble.info/wiki/Murmur.ini#allowping
[mdoc-welcometext]: https://wiki.mumble.info/wiki/Murmur.ini#welcometext
[mdoc-bandwidth]: https://wiki.mumble.info/wiki/Murmur.ini#bandwidth
[mdoc-timeout]: https://wiki.mumble.info/wiki/Murmur.ini#timeout
[mdoc-users]: https://wiki.mumble.info/wiki/Murmur.ini#users
[mdoc-usersperchannel]: https://wiki.mumble.info/wiki/Murmur.ini#usersperchannel
[mdoc-group-channelusername]: https://wiki.mumble.info/wiki/Murmur.ini#channelname_and_username
[mdoc-defaultchannel]: https://wiki.mumble.info/wiki/Murmur.ini#defaultchannel
[mdoc-rememberchannel]: https://wiki.mumble.info/wiki/Murmur.ini#rememberchannel
[mdoc-textmessagelength]: https://wiki.mumble.info/wiki/Murmur.ini#textmessagelength
[mdoc-imagemessagelength]: https://wiki.mumble.info/wiki/Murmur.ini#imagemessagelength
[mdoc-allowhtml]: https://wiki.mumble.info/wiki/Murmur.ini#allowhtml
[mdoc-opusthreshold]: https://wiki.mumble.info/wiki/Murmur.ini#opusthreshold
[mdoc-registerHostname]: https://wiki.mumble.info/wiki/Murmur.ini#registerHostname
[mdoc-registerPassword]: https://wiki.mumble.info/wiki/Murmur.ini#registerPassword
[mdoc-registerUrl]: https://wiki.mumble.info/wiki/Murmur.ini#registerUrl
[mdoc-registerName]: https://wiki.mumble.info/wiki/Murmur.ini#registerName
[mdoc-suggestVersion]: https://wiki.mumble.info/wiki/Murmur.ini#suggestVersion
[mdoc-suggestPositional]: https://wiki.mumble.info/wiki/Murmur.ini#suggestPositional
[mdoc-suggestPushToTalk]: https://wiki.mumble.info/wiki/Murmur.ini#suggestPushToTalk
[mdoc-sslcertkey]: https://wiki.mumble.info/wiki/Murmur.ini#sslCert_and_sslKey

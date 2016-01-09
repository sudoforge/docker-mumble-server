# docker-murmur

**Mumble** is a VOIP application which allows users to talk to each other via
the same server. It uses a client-server architecture, and encrypts all
communication to ensure user privacy. **Murmur** is the server that Mumble
clients to connect to. [Learn More][1].

`docker-murmur` enables you to easily run multiple (lightweight) murmur
instances on the same host.

## Getting started

This guide assumes that you already have [Docker][2] installed.

### Clone this repository

You'll probably want to clone this repository (or download it some other way).
This will create the `docker-murmur` folder in your current directory, and clone
the repository within that:

```bash
git clone https://github.com/bddenhartog/docker-murmur.git
```

### Build the image locally

Next, you'll need to build the base image locally as it is not maintained on
DockerHub (because the `data` directory is shared from all containers spawned
from the base image, it wouldn't make sense to share that base image -- in other
words, I wouldn't recommend putting your image on DockerHub).

Assuming you haven't moved directories yet, let's build an image with the
`docker-murmur` tag, so that we can easily reference it.

```bash
cd docker-murmur
docker build -t docker-murmur .
```

### Create a container

Now that you have a "base image", let's get a container up and running.

```bash
docker run -d -p <HOST-PORT>:64738 --name <YOUR-CONTAINER-NAME> docker-murmur
```

**< HOST-PORT >**  
should be replaced with an available port on the host machine.

**< CONTAINER-NAME >**  
should be replaced (e.g. `murmur-001`, `murmur-002`, `murmur-003` etc).

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

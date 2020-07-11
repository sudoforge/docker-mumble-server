# Mumble-Mumo

Mumo is for "Mumble Moderator"

See https://github.com/mumble-voip/mumo for more information.

This is the base of the mumo service. It's allow addition of new module.

docker-compose (v2) exemple :
```
services:
    mumble-mumo:
        build: docker-images/mumble-mumo
        container_name: mumble-mumo
        restart: on-failure
        volumes:
            - /path/to/mumo/folder:/data
        network_mode : "service:mumble-server"
```

Warning:
- the service network-mode is mandatory to link mumble and mumo. Ice don't like using the network other than 127.0.0.1
- the volume is to store all module/configurations, you can add yours here. Subfolders will be automatically created ad first start.
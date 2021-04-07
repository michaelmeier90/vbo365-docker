# vbo365-docker
docker based on php:apache-buster and nielsengelen/vbo365-rest pre-installed

## Installation

1. DockerCompose
```
version: "2.1"
services:
  swag:
    image: vbo365-rest:mme
    container_name: vbo365-rest
    cap_add:
      - NET_ADMIN
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Zurich
    volumes:
      - vbo365_config:/config      
      - vbo365_data:/data
    ports:
      - 4443:4443
    restart: unless-stopped 
```

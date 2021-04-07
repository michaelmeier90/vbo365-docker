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
      - 88:80
    restart: unless-stopped 
```

## Configuration
Once composer has finished, open a web browser and go to setup.php, this allows you to generate a config file. 

If this doesn't work, modify the original config.php file with your Veeam Backup for Microsoft Office 365 hostname/IP, port (default: 4443) and, API version to be used. Additionally, you can configure the custom title to be shown.

**_Remember to enable mod_rewrite as described in the dependencies._**
**_Remove the setup.php file once this is done._**

# vbo365-docker
docker based on php:apache-buster and nielsengelen/vbo365-rest pre-installed

## Installation

1. DockerCompose
```
version: "2.1"
services:
  vbo365:
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
  rproxy:
    image: linuxserver/letsencrypt
    container_name: rproxy
    cap_add:
      - NET_ADMIN
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Zurich
      - URL=e-novinfo.ch
      - SUBDOMAINS=veeam-sp
      - VALIDATION=http
      - EMAIL= support@e-novinfo.ch
      - ONLY_SUBDOMAINS=true
      #- EXTRA_DOMAINS= #optional
      #- STAGING=false #optional
    volumes:
      - /opt/letsencrpyt/config:/config
    ports:
      - 443:443
      - 80:80 #optional
    restart: unless-stopped

```

## Configuration
Once composer has finished, open a web browser and go to setup.php, this allows you to generate a config file. 

If this doesn't work, modify the original config.php file with your Veeam Backup for Microsoft Office 365 hostname/IP, port (default: 4443) and, API version to be used. Additionally, you can configure the custom title to be shown.

**_Remember to enable mod_rewrite as described in the dependencies._**
**_Remove the setup.php file once this is done._**

## Configuration NGINX (Reverse Proxy)
Add configuration file veeam-sp.e-novinfo.ch.conf in /config/nginx/proxy-confs folder 

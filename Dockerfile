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
    links:
      - vbo365
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Zurich
      - URL=e-novinfo.ch
      - SUBDOMAINS=veeam-sp,vbo365
      - VALIDATION=http
      - DNSPLUGIN=cloudflare #optional
      - DUCKDNSTOKEN=<token> #optional
      - EMAIL= support@e-novinfo.ch
      - DHLEVEL=2048 
      - ONLY_SUBDOMAINS=true
      #- EXTRA_DOMAINS= #optional
      - STAGING=false #optional
    volumes:
      - /opt/letsencrpyt/config:/config
    ports:
      - 443:443
      - 80:80 #optional
    restart: unless-stopped

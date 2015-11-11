# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- DEPOT_USER,
- DEPOT_PASSWORD
- HEADPHONES_API_KEY
- PUSHOVER_USER_KEY

# Ports
The following ports must be mapped, when running container 

 - 8081 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- /srv/headphones/config
- /srv/headphones/data
- /mnt/music
- /mnt/downloads/[Music]:/mnt/downloads
- /mnt/blackhole/[Music]:/mnt/blackhole

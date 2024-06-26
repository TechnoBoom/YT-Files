# CrowdSec IDS/IPS + Traefik

This is a guide on how to setup crowdsec IDS/IPS detection with traefik.

You have to follow the steps in a sequence in order for this to work properly without errors. 
The example configs given are final sample configs created and lack the step-by-step instructions required for this tutorial.

# Requirements :

1. Docker and docker-compose installed
2. Traefik set-up properly

# Steps for the setup :

1. mkdir crowdsec && cd crowdsec && mkdir config && cd config
2. sudo nano acquis.yaml
3. copy and paste contents of [acquis.yaml](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/config/acquis.yaml) and save the file.
4. cd ..
5. sudo nano docker-compose.yaml
6. copy and paste crowdsec's [docker-compose](https://github.com/TechnoBoom/YT-Files/blob/1060389ac23875ffcf6e80c37a9dc9f42069996a/IDS-IPS-Crowdsec-Traefik/docker-compose.yaml) file's contents here and save the file.

Traefik :

8. cd .. && cd traefik && cd data
9. sudo nano traefik.yml
10. copy and paste lines for logs (lines 39 - 43) from [traefik.yml](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/traefik/data/traefik.yml#L39) and save it.
11. cd ..
12. sudo nano docker-compose.yml
13. copy and paste contents of traefik's [docker-compose](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/traefik/docker-compose.yml) and save the file.
14. sudo docker-compose down && sudo docker-compose up -d --force-recreate
15. cd .. && cd crowdsec
16. sudo docker-compose down && sudo docker-compose up -d --force-recreate

CrowdSec :

17. docker exec crowdsec cscli decisions list                                          #Check if access.log is listed at top or not
18. docker exec crowdsec cscli bouncers add bouncer-traefik                            #Add API key into bouncer's [docker-compose](https://github.com/TechnoBoom/YT-Files/blob/1060389ac23875ffcf6e80c37a9dc9f42069996a/IDS-IPS-Crowdsec-Traefik/docker-compose.yaml#L24) here.

Traefik :

19. cd .. && cd traefik && cd data
20. sudo nano config.yml
21. copy and paste CrowdSec's Bouncer MiddleWare from lines (42 - 45) from [config.yml](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/traefik/data/config.yml#L42) to the traefik's config.yml and save it.
22. sudo nano traefik.yml
23. copy and paste middleware enabler in lines (16 - 18) to both http and https sections like shown in [traefik.yml](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/traefik/data/traefik.yml#L16) and save the file.
24. sudo docker-compose down && sudo docker-compose up -d --force-recreate

Crowdsec :

25. To verify if CrowdSec is working, run [commands](https://github.com/TechnoBoom/YT-Files/blob/9134dae38321b4c76d54bd6b1c5c1c38ffd44868/IDS-IPS-Crowdsec-Traefik/commands%20list#L12) and and or delete your ip address. You can also check decisions list.

Crontab :

26. crontab -e                                                                         # select 1 for nano
27. go to the  last line and paste the below command and save it.
28. " * 3 * * * docker exec crowdsec cscli hub update && docker exec crowdsec cscli hub upgrade "          #Inside Quotes
29. This command will update the blocklist every 3 hours.

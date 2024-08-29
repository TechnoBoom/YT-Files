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
3. copy and paste contents of [acquis.yaml](https://github.com/TechnoBoom/YT-Files/blob/19201be2fd8b99d0388a587b1b648b23ac07b7b0/IDS-IPS-Crowdsec-Traefik/crowdsec/config/acquis.yaml) and save the file.
4. cd ..
5. sudo nano docker-compose.yaml
6. copy and paste crowdsec's [docker-compose](https://github.com/TechnoBoom/YT-Files/blob/4518d6f39a551de0c1390b9d17ee1767b345851f/IDS-IPS-Crowdsec-Traefik/crowdsec/docker-compose.yaml) file's contents here and save the file.

Traefik :

8. cd .. && cd traefik && cd data
9. sudo nano traefik.yml
10. copy and paste lines for logs (lines 41 - 45) and plugins (lines 48 - 56) from [traefik.yml](https://github.com/TechnoBoom/YT-Files/blob/4bf2948c4634f849d961aa3831207157ce56735d/IDS-IPS-Crowdsec-Traefik/traefik/data/traefik.yml#L41) and save it.
11. cd ..
12. sudo nano docker-compose.yml
13. copy and paste contents of traefik's [docker-compose](https://github.com/TechnoBoom/YT-Files/blob/5e48ac91c60771a114e977536c3589cd8e5f9756/IDS-IPS-Crowdsec-Traefik/traefik/docker-compose.yml) and save the file.
14. sudo docker compose down && sudo docker compose up -d --force-recreate
15. cd .. && cd crowdsec
16. sudo docker compose down && sudo docker compose up -d --force-recreate

CrowdSec :

17. docker exec crowdsec cscli decisions list                                          # Check if access.log is listed at top or not
18. docker exec crowdsec cscli bouncers add crowdsecBouncer                            # Add API key into bouncer's [config.yml](https://github.com/TechnoBoom/YT-Files/blob/0f558d8868d9d447664fd520ccd151f6a55bfca3/IDS-IPS-Crowdsec-Traefik/traefik/data/config.yml#L56) here after step 21.

Traefik :

19. cd .. && cd traefik && cd data
20. sudo nano config.yml
21. copy and paste CrowdSec's Bouncer Plugin from lines (42 - 68) and  Cloudflare IP Fix (lines 70 - 75) from [config.yml](https://github.com/TechnoBoom/YT-Files/blob/0f558d8868d9d447664fd520ccd151f6a55bfca3/IDS-IPS-Crowdsec-Traefik/traefik/data/config.yml#L42) to the traefik's config.yml and save it.
22. replace Crowdsec's LAPI key from step 18 [here](https://github.com/TechnoBoom/YT-Files/blob/0f558d8868d9d447664fd520ccd151f6a55bfca3/IDS-IPS-Crowdsec-Traefik/traefik/data/config.yml#L56)
23. sudo nano traefik.yml
24. copy and paste middleware enabler in lines (7 - 14) and lines (17 - 20) to both http and https sections like shown in [traefik.yml](https://github.com/TechnoBoom/YT-Files/blob/4bf2948c4634f849d961aa3831207157ce56735d/IDS-IPS-Crowdsec-Traefik/traefik/data/traefik.yml#L7) and save the file.
25. sudo docker-compose down && sudo docker-compose up -d --force-recreate

Crowdsec :

25. To verify if CrowdSec is working, run [commands](https://github.com/TechnoBoom/YT-Files/blob/0f558d8868d9d447664fd520ccd151f6a55bfca3/IDS-IPS-Crowdsec-Traefik/commands%20list#L12) and and or delete your ip address. You can also check decisions list.

Crontab :

26. crontab -e                                                                         # select 1 for nano
27. go to the  last line and paste the below command and save it.
28. " * 3 * * * docker exec crowdsec cscli hub update && docker exec crowdsec cscli hub upgrade "          # only Inside Quotes data
29. This command will update the blocklist every 3 hours.

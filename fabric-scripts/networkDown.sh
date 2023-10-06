#!/bin/bash

docker-compose -f docker/docker-compose-2org.yaml down
docker-compose -f docker/docker-compose-ca.yaml down
docker-compose -f docker/docker-compose-peer1org1.yaml down

docker rm -f $(docker ps -a | awk '($2 ~ /dev-peer.*/) {print $1}')

docker volume rm $(docker volume ls -q)

sudo rm -rf channel-artifacts/
sudo rm basic.tar.gz
sudo rm -rf organizations/

docker ps -a

docker rm $(docker container ls -q) --force

yes | docker container prune

yes | docker system prune

yes | docker volume prune

yes | docker network prune

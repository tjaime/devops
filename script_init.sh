#!/bin/bash

apt-get install git -y

curl https://releases.rancher.com/install-docker/19.03.sh | sh

usermod -aG docker ubuntu

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cd /home/ubuntu/

git clone https://github.com/jonathanbaraldi/devops.git

cd /home/ubuntu/devops/exercicios/app/redis

docker build -t thiagojaime/redis:devops .

docker run -d --name redis -p 6379:6379 thiagojaime/redis:devops

cd /home/ubuntu/devops/exercicios/app/node

docker build -t thiagojaime/node:devops .

docker run -d --name node -p 8080:8080 --link redis thiagojaime/node:devops

cd /home/ubuntu/devops/exercicios/app/nginx

docker build -t thiagojaime/nginx:devops . 

docker run -d --name nginx -p 80:80 --link node thiagojaime/nginx:devops


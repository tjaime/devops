#!/bin/bash

yum update -y

yum install git -y

amazon-linux-extras install docker -y

usermod -a -G docker ec2-user

service docker start

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cd /home/ec2-user/

git clone https://github.com/jonathanbaraldi/devops.git

cd /home/ec2-user/devops/exercicios/app/redis

docker build -t thiagojaime/redis:devops . 

cd /home/ec2-user/devops/exercicios/app/node

docker build -t thiagojaime/node:devops . 

cd /home/ec2-user/devops/exercicios/app/nginx

docker build -t thiagojaime/nginx:devops . 

cd /home/ec2-user/devops/

tee -a docker-compose.yml <<EOF
# Versão 2 do Docker-Compose
version: '2'

services:
    
    nginx:
        restart: "always"
        image: thiagojaime/nginx:devops
        ports:
            - "80:80"
        links:
            # Colocar mais nós para escalar
            - node
            # - node-2
            
    redis:
        restart: "always"
        image: thiagojaime/redis:devops
        ports:
            - 6379

    mysql:
        restart: "always"
        image: mysql
        ports:
            - 3306
        environment:
            MYSQL_ROOT_PASSWORD: 123
            MYSQL_DATABASE: books
            MYSQL_USER: apitreinamento
            MYSQL_PASSWORD: 123 
    
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    node:
        restart: "always"
        image: thiagojaime/node:devops
        links:
            - redis
            - mysql
        ports:
            - 8080
        volumes:
            -  volumeteste:/tmp/volumeteste
    
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Mapeamento dos volumes
volumes:
    volumeteste:
        external: false
EOF

docker-compose -f docker-compose.yml up -d




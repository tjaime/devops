# devops
Requisito mínimo  de hardware

2   -  CPU  \
6GB -  Mem  

Sistema Operacional
Ubuntu Server 16.04 LTS (HVM), SSD Volume Type

Família
t2 - t2.medium

Instâncias
4

ssh -i "../tj-aws-console.pem" ubuntu@3.86.96.60       - Rancher Server      
ssh -i "../tj-aws-console.pem" ubuntu@54.165.78.251    - k8s1                \
ssh -i "../tj-aws-console.pem" ubuntu@184.72.200.227   - k8s2                \
ssh -i "../tj-aws-console.pem" ubuntu@3.92.187.24      - k8s3                \

instalar em cada máquina o docker                                \
sudo su -                                                        \
apt-get install git -y
curl https://releases.rancher.com/install-docker/19.03.sh | sh   \
usermod -aG docker ubuntu                                        

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cd /home/ubuntu/

git clone https://github.com/jonathanbaraldi/devops.git

docker rm -f $(docker ps -a -q)

1. REDIS - build redis
cd /home/ubuntu/devops/exercicios/app/redis
docker build -t thiagojaime/redis:devops .
docker run -d --name reds -p 6379:6379 thiagojaime/redis:devops
docker ps
docker logs redis

2. NODE AND MYSQL  
cd /home/ubuntu/devops/exercicios/app/node
docker build -t thiagojaime/node:devops .
docker run -d --name node -p 8080:8080 --link redis thiagojaime/node:devops
docker ps
docker logs node

3. cd /home/ubuntu/devops/exercicios/app/nginx
docker build -t thiagojaime/nginx:devops .
docker run -d --name nginx -p 80:80 --link node thiagojaime/nginx:devops 
docker ps
docker logs nginx

Teste - IP Rancher Server
http://3.86.96.60/
http://3.86.96.60/redis





.

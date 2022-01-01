# Referência
# https://github.com/jonathanbaraldi/devops/blob/e65d1706e772f62bf7abe83b0d1f9c4db7e4e05c/exercicios/exercicios.md

# devops
Requisito mínimo  de hardware

2   -  CPU  \
6GB -  Mem  

Sistema Operacional
Ubuntu Server 20

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
docker run -d --name redis -p 6379:6379 thiagojaime/redis:devops
docker ps
docker logs redis

2. NODE AND MYSQL
cd /home/ubuntu/devops/exercicios/app/node
docker build -t thiagojaime/node:devops .
docker run -d --name node -p 8080:8080 --link redis thiagojaime/node:devops
docker ps
docker logs node

3. NGINX

cd /home/ubuntu/devops/exercicios/app/nginx
docker build -t thiagojaime/nginx:devops .
docker run -d --name nginx -p 80:80 --link node thiagojaime/nginx:devops 
docker ps
docker logs nginx

Teste - IP Rancher Server
http://3.86.96.60/
http://3.86.96.60/redis      \


docker container run --name mysqldb -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=bootdb -d mysql:8

MYSQL_ROOT_PASSWORD=123
MYSQL_DATABASE=bootdb




sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.4.3 --server https://rancher.thiagojaime.com.br --token zrwq77g4l59ws5jlllhsbpvv4sgg2tzns2rr6vtjhjxn4w885kxrqg --ca-checksum 5b541412b26c3094db5addcfa308a435f12f719a575949dbbf63c09ee2b949ca --node-name k81-2 --etcd --controlplane --worker


.
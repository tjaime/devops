# devops
Requisito de hardware

ssh -i "../tj-aws-console.pem" ubuntu@ip   - Rancher Server
ssh -i "../tj-aws-console.pem" ubuntu@ip   - k8s1
ssh -i "../tj-aws-console.pem" ubuntu@ip   - k8s2
ssh -i "../tj-aws-console.pem" ubuntu@ip   - k8s3

sudo su -
curl https://releases.rancher.com/install-docker/19.03.sh | sh
usermod -aG docker ubuntu


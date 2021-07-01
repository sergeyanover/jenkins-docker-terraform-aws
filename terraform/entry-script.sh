#!/usr/bin/env bash
sudo yum update -y && sudo yum install -y docker && sudo yum install -y git
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

docker pull alpine/git

cd /home/ec2-user
git clone https://github.com/sergeyanover/jenkins-docker-terraform-aws.git
cd jenkins-docker-terraform-aws
cd jenkins
docker build -t jenkins .
docker tag jenkins aws-docker-jenkins:v1

docker run --name jenkins -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home aws-docker-jenkins:v1

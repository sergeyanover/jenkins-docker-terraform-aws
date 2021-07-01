#!/usr/bin/env bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

docker pull alpine/git

docker run -ti --rm -v /home/ec2-user:/root -v /home/ec2-user:/git alpine/git clone https://github.com/sergeyanover/jenkins-docker-terraform-aws.git
cd jenkins-docker-terraform-aws
cd jenkins
docker build -t jenkins .
docker tag jenkins aws-docker-jenkins:v1

docker run --name jenkins -d -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home aws-docker-jenkins:v1

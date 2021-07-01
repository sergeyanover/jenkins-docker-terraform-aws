data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}


resource "aws_key_pair" "ssh_key" {
  key_name = "dev-web-jenkins"
  public_key = var.my_public_key
}


resource "aws_instance" "dev_jenkins" {
  ami = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.dev_subnet_1.id
  vpc_security_group_ids = [aws_security_group.dev-web-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true

  key_name = aws_key_pair.ssh_key.key_name


  user_data = file("entry-script.sh")


  tags = {
    Name = "dev-ec2-jenkins"
  }
}




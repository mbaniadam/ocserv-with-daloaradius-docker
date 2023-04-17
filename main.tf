# Set the required provider and versions
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}


resource "aws_instance" "ocserv" {
  ami    = "ami-02c68996dd3d909c1"
  instance_type = "t3.micro"
  key_name = "key"
  vpc_security_group_ids = [resource.aws_security_group.webSG.id]
  
  connection {
    type     = "ssh"
    user     = "admin"
    host     = "${self.public_ip}"
    private_key = file("private_key/key.pem")
  }

# When using the ssh connection type the destination directory must already exist.
  provisioner "remote-exec" { 
    inline = [
      "mkdir /tmp/app",
      "chmod 777 /tmp/app"
    ]
  }

  provisioner "file" {
    source      = "app/"
    destination = "/tmp/app"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo rm /var/lib/dpkg/lock",
        "sudo dpkg --configure -a",
        "sudo apt-get update && sudo apt install docker.io docker-compose -y",
        "cd /tmp/app",
        "sudo docker-compose up -d",
    ]
  }
}

# we must set security group
resource "aws_security_group" "webSG" {
  name        = "Allow SSH and Web"
  description = "Allow ssh  inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1
    to_port     = 8
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}
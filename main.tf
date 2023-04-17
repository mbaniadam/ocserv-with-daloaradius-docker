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
  key_name = "key1"
  vpc_security_group_ids = [resource.aws_security_group.webSG.id]
  

  provisioner "file" {
    source      = "app/"
    destination = "/app"
    connection {
      type     = "ssh"
      user     = "admin"
      host     = "${self.public_ip}"
      private_key = file("private_key/key1.pem")

    }
  }

  provisioner "remote-exec" {
    inline = [
        "cd /app",
        "docker-compose up -d",
    ]

  }
}

# we must set security group
resource "aws_security_group" "webSG" {
  name        = "webSG"
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

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}
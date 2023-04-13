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

  provisioner "file" {
    source      = "app/"
    destination = "/app"
  }

  provisioner "remote-exec" {
    inline = [
        "cd /app",
        "docker-compose up -d",
    ]

  }
}
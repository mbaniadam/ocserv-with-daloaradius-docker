# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}


resource "aws_instance" "ocserv" {
  ami    = "ami-02c68996dd3d909c1"
  instance_instance_type = "t3.micro"

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
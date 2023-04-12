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

# Create a docker image resource
resource "docker_image" "daloradius" {
  name         = "frauhottelmann/daloradius-docker:1.2"
  keep_locally = true
}

resource "docker_image" "ocserv" {
  name         = "tommylau/ocserv:0.12.1"
  keep_locally = true
}

# Create a docker container resource
# -> same as 'docker run --name ocserv -p 443:443 -d nginx:latest'
resource "docker_container" "daloradius" {
  name    = "daloradius"
  image   = docker_image.daloradius.image_id

  ports {
    external = [1812,1813,8080]
    internal = [1812,1813,80]

  }
}

resource "docker_network" "private_network" {
  name   = var.container_network.name
  driver = var.container_network.driver
}


resource "docker_container" "ocserv" {
  name    = "ocserv"
  image   = docker_image.ocserv.image_id

  ports {
    external = 443
    internal = 443
  }
}

provisioner "remote-exec" {
  inline = [
    "sed -i '33i\radius            secretmor' /etc/freeradius/3.0/client.conf"
  ]

}
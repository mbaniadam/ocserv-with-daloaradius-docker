
variable "keep_locally" {
  default     = false
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
}

variable "force_remove" {
  default     = true
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
}

variable "read_only" {
  default     = false
  type        = bool
  description = "If true, this volume will be readonly. Defaults to false"
}
variable "container_restart" {
  default     = "always"
  type        = string
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'. Defaults to no."
}
variable "container_network" {
  type = object({
    name   = string
    driver = string
  })
  default = {
    driver = "bridge"
    name   = "nginx_network"
  }
}
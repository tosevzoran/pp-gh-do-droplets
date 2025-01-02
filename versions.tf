terraform {
  required_version = "~> 1.10.3"

  required_providers {
    godaddy-dns = {
      source  = "registry.terraform.io/veksh/godaddy-dns"
      version = "~> 0.3.9"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

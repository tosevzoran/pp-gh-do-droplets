locals {
  droplets = {
    "basic-web" = {
      image  = "ubuntu-24-10-x64"
      region = "fra1"
      size   = "s-1vcpu-512mb-10gb"

      domain = {
        records = [
          {
            domain = "image.sandboxs.me"
            type   = "A"
            name   = "@"
          }
        ]
      }
    }
  }
}

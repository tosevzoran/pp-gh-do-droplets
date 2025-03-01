resource "digitalocean_ssh_key" "self" {
  name       = "do-deploy"
  public_key =  var.ssh_deploy_key_public
}

resource "digitalocean_droplet" "self" {
  for_each = local.droplets

  name = each.key

  image  = each.value.image
  region = each.value.region
  size   = each.value.size

  ssh_keys = [digitalocean_ssh_key.self.fingerprint]
}

resource "cloudflare_record" "self" {
  for_each = { for record_key, record in flatten([
    for droplet_key, droplet in local.droplets : [
      for record in droplet.domain.records : {
        name   = record.name
        type   = record.type
        domain = record.domain
        data   = digitalocean_droplet.self[droplet_key].ipv4_address
      }
    ]
  ]) : record_key => record }

  name    = each.value.domain
  type    = each.value.type
  content = each.value.data
  zone_id = var.zone_id
}

# resource "godaddy-dns_record" "self" {
#   for_each = { for record_key, record in flatten([
#     for droplet_key, droplet in local.droplets : [
#       for record in droplet.domain.records : {
#         name   = record.name
#         type   = record.type
#         domain = record.domain
#         data   = digitalocean_droplet.self[droplet_key].ipv4_address
#       }
#     ]
#   ]) : record_key => record }
#
#   name   = each.value.name
#   type   = each.value.type
#   domain = each.value.domain
#   data   = each.value.data
# }

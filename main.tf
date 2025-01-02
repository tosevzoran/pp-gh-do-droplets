resource "digitalocean_droplet" "self" {
  for_each = local.droplets

  name = each.key

  image  = each.value.image
  region = each.value.region
  size   = each.value.size
}

resource "godaddy-dns_record" "self" {
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

  name   = each.value.name
  type   = each.value.type
  domain = each.value.domain
  data   = each.value.data
}

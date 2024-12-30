resource "digitalocean_droplet" "self" {
  for_each = local.droplets

  name = each.key

  image  = each.value.image
  region = each.value.region
  size   = each.value.size
}

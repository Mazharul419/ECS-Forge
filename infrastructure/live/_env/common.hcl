### Contains app configuration common across all environments ###

locals {
  container_port     = 8080
  domain_name        = "mazharulislam.dev"
  cloudflare_zone_id = get_env("CLOUDFLARE_ZONE_ID")
}
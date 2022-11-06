module "backend" {
  source = "../../modules/backend"

  project_id        = var.project_id
  iap_client_id     = var.iap_client_id
  iap_client_secret = var.iap_client_id
  managed_zone_name = var.managed_zone_name
}
// NOTE: Cloud Domains から払い出された managed zone を利用
data "google_dns_managed_zone" "main" {
  project = var.project_id

  name = var.managed_zone_name
}

resource "google_dns_record_set" "frontend" {
  project = var.project_id

  name = "api.${data.google_dns_managed_zone.main.dns_name}"
  type = "A"
  ttl  = 30

  managed_zone = data.google_dns_managed_zone.main.name

  rrdatas = [module.load_balancer.external_ip]
}

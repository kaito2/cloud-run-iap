locals {
  load_balancer_name = "sample"
}

module "load_balancer" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "6.3.0"

  project = var.project_id
  name    = local.load_balancer_name

  ssl = true
  managed_ssl_certificate_domains = [
    // NOTE: `dns_name` は fully qualified DNS name なので、末尾のドットを取り除く
    //       e.g. "google.com." -> "google.com"
    "api.${trimsuffix(data.google_dns_managed_zone.main.dns_name, ".")}"
  ]
  https_redirect = true

  backends = {
    (local.app1_name) = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.app1.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null

      iap_config = {
        enable               = true
        oauth2_client_id     = var.iap_client_id
        oauth2_client_secret = var.iap_client_secret
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
    }
  }
}

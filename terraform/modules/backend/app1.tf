locals {
  app1_name = "app1"
}

data "google_iam_policy" "app1" {
  binding {
    role = "roles/iap.httpsResourceAccessor"
    members = [
      // "group:everyone@google.com", // a google group
      // "allAuthenticatedUsers"          // anyone with a Google account (not recommended)
      "user:user@example.com", // a particular user
    ]
  }
}

resource "google_iap_web_backend_service_iam_policy" "app1" {
  project = var.project_id
  # NOTE: terraform-google-lb-http module-specific format
  #       See: https://github.com/terraform-google-modules/terraform-google-lb-http/blob/master/modules/dynamic_backends/main.tf#L174
  web_backend_service = "${local.load_balancer_name}-backend-${local.app1_name}"
  policy_data         = data.google_iam_policy.app1.policy_data
  depends_on = [
    module.load_balancer
  ]

}

resource "google_compute_region_network_endpoint_group" "app1" {
  project               = var.project_id
  provider              = google
  name                  = local.app1_name
  network_endpoint_type = "SERVERLESS"
  region                = local.region
  cloud_run {
    service = google_cloud_run_service.app1.name
  }
}

resource "google_vpc_access_connector" "app1" {
  name          = local.app1_name
  region        = local.region
  project       = var.project_id
  ip_cidr_range = "10.8.0.0/28"
  network       = "default"
}

resource "google_cloud_run_service" "app1" {
  name     = local.app1_name
  location = local.region
  project  = var.project_id

  metadata {
    annotations = {
      "run.googleapis.com/ingress" : "internal-and-cloud-load-balancing"
    }
  }
  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" : google_vpc_access_connector.app1.name
      }
    }
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
}

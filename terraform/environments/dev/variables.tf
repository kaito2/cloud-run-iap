variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "managed_zone_name" {
  type        = string
  description = "Name of the managed_zone that manages the domain used by the Load balancer."
}

variable "iap_client_id" {
  type        = string
  sensitive   = false
  description = "The client id for the OAuth client."
}

variable "iap_client_secret" {
  type        = string
  sensitive   = true
  description = <<-EOT
  The client secret for the OAuth client.
  You can view it by editing the oAuth client.
  EOT
}
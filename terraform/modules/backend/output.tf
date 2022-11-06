output "oauth2_redirect_uri" {
  value = "https://iap.googleapis.com/v1/oauth/clientIds/${var.iap_client_id}:handleRedirect"
}

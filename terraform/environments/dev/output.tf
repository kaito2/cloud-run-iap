output "oauth2_redirect_uri" {
  description = "Register for `OAuth 2.0 client ID` as `Authorized redirect URI`."
  value       = module.backend.oauth2_redirect_uri
}

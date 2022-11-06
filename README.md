# Cloud Run with IAP

## NOTE
- Cloud Domains resources cannot be managed by terraform.
  - For more details: [Support Cloud Domains API · Issue #7696 · hashicorp/terraform-provider-google · GitHub](https://togithub.com/hashicorp/terraform-provider-google/issues/7696)
- The resource corresponding to `google_dns_managed_zone` is **not** managed by terraform.
  - Use the managed_zone generated when acquiring a domain in Cloud Domains.

## Deploy

Create OAuth2 web application (and note its client id and client secret).

```
cd terraform/environments/dev

terraform init
terraform apply
```

## Cleanup

```
terraform destroy
```

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [cloudflare_dns_record.cert_validation](https://registry.terraform.io/providers/hashicorp/cloudflare/latest/docs/resources/dns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#input\_cloudflare\_zone\_id) | Cloudflare Zone ID for DNS validation | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Root domain name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain for the certificate | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ARN of the validated certificate |
| <a name="output_certificate_domain"></a> [certificate\_domain](#output\_certificate\_domain) | Domain name of the certificate |
| <a name="output_certificate_status"></a> [certificate\_status](#output\_certificate\_status) | Status of the certificate |
| <a name="output_validation_record_fqdns"></a> [validation\_record\_fqdns](#output\_validation\_record\_fqdns) | FQDNs of the validation records |

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [cloudflare_dns_record.app](https://registry.terraform.io/providers/hashicorp/cloudflare/latest/docs/resources/dns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alb_dns_name"></a> [alb\_dns\_name](#input\_alb\_dns\_name) | DNS name of the ALB | `string` | n/a | yes |
| <a name="input_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#input\_cloudflare\_zone\_id) | Cloudflare Zone ID | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Root domain name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain to create (e.g., tm-dev) | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | Fully qualified domain name |
| <a name="output_record_id"></a> [record\_id](#output\_record\_id) | Cloudflare record ID |

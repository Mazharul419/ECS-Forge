## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_vpc_endpoint.ecr_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the VPC endpoints will be created. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_private_route_table_ids"></a> [private\_route\_table\_ids](#input\_private\_route\_table\_ids) | List of private route table IDs where the s3 gateway endpoint will be added. | `list(string)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs where interface endpoints will be created. | `list(string)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_vpc_endpoints_security_group_id"></a> [vpc\_endpoints\_security\_group\_id](#input\_vpc\_endpoints\_security\_group\_id) | The security group ID to associate with the interface VPC endpoints. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the endpoints will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ecr_api_endpoint_id"></a> [ecr\_api\_endpoint\_id](#output\_ecr\_api\_endpoint\_id) | ID of the ECR API interface endpoint |
| <a name="output_ecr_dkr_endpoint_id"></a> [ecr\_dkr\_endpoint\_id](#output\_ecr\_dkr\_endpoint\_id) | ID of the ECR DKR interface endpoint |
| <a name="output_logs_endpoint_id"></a> [logs\_endpoint\_id](#output\_logs\_endpoint\_id) | ID of the CloudWatch Logs interface endpoint |
| <a name="output_s3_endpoint_id"></a> [s3\_endpoint\_id](#output\_s3\_endpoint\_id) | ID of the S3 gateway endpoint |

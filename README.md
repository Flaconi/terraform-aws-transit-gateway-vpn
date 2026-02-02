# Terraform AWS Transit Gateway VPN module

We are following the hub-spoke(s) (aka [star network][1]) network topology
model.

This module joins our other two modules for handling the Transit Gateway "hub"
and "satellite" nodes:

- [terraform-aws-transit-gateway-hub][2]
- [terraform-aws-transit-gateway-satellite][3]

Specifically, we are attaching the VPN connection to the TGW by manipulating
the VPN configuration directly, as there isn't a resource for explicitly doing
so, like in the case of the VPC attachments. Sadly, this is a [limitation on the
AWS side][4].

The VPN related resources handled by this module are provisioned and configured
in the "hub" node.

Check out some use cases in the [examples](/examples/).

## Caveats

__Routing:__ When the VPN is attached to the TGW, there can be no static routes
configured as the routing needs to be added through the TGW API.

## Assumptions

### Credentials

The module starts from the assumption that your default aws profile allows the
user to assume the necessary IAM roles, as required, to make the necessary
changes. You can use profile of your need if you set `AWS_PROFILE` or `AWS_DEFAULT_PROFILE`, e.g.:

```shell
export AWS_DEFAULT_PROFILE=login
```

You can read more about how Terraform handles this [here][5].

Obviously, all the [supported authentication][6] methods can also be used.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_transit_gateway_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_vpn_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway) | data source |
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_route_table) | data source |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ram_resource_share) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cgw_bgp_asn"></a> [cgw\_bgp\_asn](#input\_cgw\_bgp\_asn) | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `string` | n/a | yes |
| <a name="input_cgw_ip_address"></a> [cgw\_ip\_address](#input\_cgw\_ip\_address) | IP address of the client VPN endpoint | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Generic name to be given to the provisioned resources | `string` | n/a | yes |
| <a name="input_transit_gateway_hub_account_id"></a> [transit\_gateway\_hub\_account\_id](#input\_transit\_gateway\_hub\_account\_id) | AWS account ID of Transit Gateway owner | `string` | n/a | yes |
| <a name="input_transit_gateway_hub_name"></a> [transit\_gateway\_hub\_name](#input\_transit\_gateway\_hub\_name) | Name of the Transit Gateway to attach the VPN to | `string` | n/a | yes |
| <a name="input_log_enabled"></a> [log\_enabled](#input\_log\_enabled) | Whether to enable logging for the Transit Gateway VPN connection. | `bool` | `false` | no |
| <a name="input_log_group_arn"></a> [log\_group\_arn](#input\_log\_group\_arn) | ARN of an existing CloudWatch Log Group to use when logging is enabled. This module does not create or manage the log group. | `string` | `null` | no |
| <a name="input_log_output_format"></a> [log\_output\_format](#input\_log\_output\_format) | Output format for VPN logs when logging is enabled (for example: json). | `string` | `"json"` | no |
| <a name="input_static_routes_destinations"></a> [static\_routes\_destinations](#input\_static\_routes\_destinations) | List of CIDRs to be routed into the VPN tunnel. | `list(string)` | `[]` | no |
| <a name="input_static_routes_only"></a> [static\_routes\_only](#input\_static\_routes\_only) | Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of custom tags for the provisioned resources | `map(string)` | `{}` | no |
| <a name="input_tunnel1_inside_cidr"></a> [tunnel1\_inside\_cidr](#input\_tunnel1\_inside\_cidr) | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | `null` | no |
| <a name="input_tunnel1_preshared_key"></a> [tunnel1\_preshared\_key](#input\_tunnel1\_preshared\_key) | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | `null` | no |
| <a name="input_tunnel2_inside_cidr"></a> [tunnel2\_inside\_cidr](#input\_tunnel2\_inside\_cidr) | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | `null` | no |
| <a name="input_tunnel2_preshared_key"></a> [tunnel2\_preshared\_key](#input\_tunnel2\_preshared\_key) | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_gateway_id"></a> [customer\_gateway\_id](#output\_customer\_gateway\_id) | ID of the Customer Gateway |
| <a name="output_vpn_connection"></a> [vpn\_connection](#output\_vpn\_connection) | VPN connection details |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

[1]: https://en.wikipedia.org/wiki/Star_network
[2]: https://github.com/Flaconi/terraform-aws-transit-gateway-hub
[3]: https://github.com/Flaconi/terraform-aws-transit-gateway-satellite
[4]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html
[5]: https://www.terraform.io/docs/configuration/modules.html#passing-providers-explicitly
[6]: https://www.terraform.io/docs/providers/aws/index.html#authentication

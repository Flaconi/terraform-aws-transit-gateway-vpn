# Complete test case for the VPN module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpn"></a> [vpn](#module\_vpn) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_account_id"></a> [allowed\_account\_id](#input\_allowed\_account\_id) | AWS account ID for which this module can be executed | `string` | n/a | yes |
| <a name="input_cgw_bgp_asn"></a> [cgw\_bgp\_asn](#input\_cgw\_bgp\_asn) | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `string` | n/a | yes |
| <a name="input_cgw_ip_address"></a> [cgw\_ip\_address](#input\_cgw\_ip\_address) | IP address of the client VPN endpoint | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Generic name to be given to the provisioned resources | `string` | n/a | yes |
| <a name="input_transit_gateway_hub_name"></a> [transit\_gateway\_hub\_name](#input\_transit\_gateway\_hub\_name) | Name of the Transit Gateway to attach the VPN to | `string` | n/a | yes |
| <a name="input_role_to_assume"></a> [role\_to\_assume](#input\_role\_to\_assume) | IAM role name to assume (eg. ASSUME-ROLE-HUB) | `string` | `""` | no |
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

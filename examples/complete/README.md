# Complete test case for the VPN module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allowed\_account\_id | AWS account ID for which this module can be executed | `string` | n/a | yes |
| aws\_login\_profile | Name of the AWS login profile as seen under ~/.aws/config | `any` | n/a | yes |
| cgw\_bgp\_asn | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `string` | n/a | yes |
| cgw\_ip\_address | IP address of the client VPN endpoint | `string` | n/a | yes |
| name | Generic name to be given to the provisioned resources | `string` | n/a | yes |
| transit\_gateway\_hub\_name | Name of the Transit Gateway to attach the VPN to | `string` | n/a | yes |
| tunnel1\_inside\_cidr | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | n/a | yes |
| tunnel1\_preshared\_key | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | n/a | yes |
| tunnel2\_inside\_cidr | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | n/a | yes |
| tunnel2\_preshared\_key | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | n/a | yes |
| role\_to\_assume | IAM role name to assume (eg. ASSUME-ROLE-HUB) | `string` | `""` | no |
| static\_routes\_destinations | List of CIDRs to be routed into the VPN tunnel. | `list` | `[]` | no |
| static\_routes\_only | Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP | `bool` | `false` | no |
| subnet\_filters | List of maps selecting the subnet(s) for which the routing will be added | <pre>list(object({<br>    name   = string<br>    values = list(string)<br>  }))<br></pre> | <pre>[<br>  {<br>    "name": "tag:Name",<br>    "values": [<br>      "private"<br>    ]<br>  }<br>]<br></pre> | no |
| tags | Map of custom tags for the provisioned resources | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| customer\_gateway\_id | ID of the Customer Gateway |
| vpn\_connection | VPN connection details |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

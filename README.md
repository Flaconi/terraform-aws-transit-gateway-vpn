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

The module starts from the assumption that the `aws_login_profile` allows the
user to assume the necessary IAM roles, as required, to make the necessary
changes.

You can read more about how Terraform handles this [here][5].

Obviously, all the [supported authentication][6] methods can also be used.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_account\_id | AWS account ID for which this module can be executed | `string` | n/a | yes |
| cgw\_bgp\_asn | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `string` | n/a | yes |
| cgw\_ip\_address | IP address of the client VPN endpoint | `string` | n/a | yes |
| name | Generic name to be given to the provisioned resources | `string` | n/a | yes |
| transit\_gateway\_hub\_name | Name of the Transit Gateway to attach the VPN to | `string` | n/a | yes |
| role\_to\_assume | IAM role name to assume (eg. ASSUME-ROLE-HUB) | `string` | `""` | no |
| static\_routes\_destinations | List of CIDRs to be routed into the VPN tunnel. | `list(string)` | `[]` | no |
| static\_routes\_only | Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP | `bool` | `false` | no |
| tags | Map of custom tags for the provisioned resources | `map(string)` | `{}` | no |
| tunnel1\_inside\_cidr | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | `null` | no |
| tunnel1\_preshared\_key | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | `null` | no |
| tunnel2\_inside\_cidr | A size /30 CIDR block from the 169.254.0.0/16 range | `string` | `null` | no |
| tunnel2\_preshared\_key | Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(\_) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| customer\_gateway\_id | ID of the Customer Gateway |
| vpn\_connection | VPN connection details |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

[1]: https://en.wikipedia.org/wiki/Star_network
[2]: https://github.com/Flaconi/terraform-aws-transit-gateway-hub
[3]: https://github.com/Flaconi/terraform-aws-transit-gateway-satellite
[4]: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html
[5]: https://www.terraform.io/docs/configuration/modules.html#passing-providers-explicitly
[6]: https://www.terraform.io/docs/providers/aws/index.html#authentication

variable "allowed_account_id" {
  description = "AWS account ID for which this module can be executed"
  type        = string
}

variable "role_to_assume" {
  description = "IAM role name to assume (eg. ASSUME-ROLE-HUB)"
  type        = string
  default     = ""
}

variable "aws_login_profile" {
  description = "Name of the AWS login profile as seen under ~/.aws/config"
}

variable "name" {
  description = "Generic name to be given to the provisioned resources"
  type        = string
}
variable "tags" {
  description = "Map of custom tags for the provisioned resources"
  type        = map
  default     = {}
}

variable "vgw_vpc_name_to_attach" {
  description = "Name of the VPC to be attached to the VPN Gateway (VGW)"
  type        = string
}

variable "vgw_az" {
  description = "Choice between eu-central-1a & eu-central-1b for provisioning the Virtual Private Gateway"
  type        = string
  default     = "eu-central-1a"
}
variable "vgw_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN."
  type        = string
  default     = null
}
variable "cgw_bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  type        = string
}
variable "cgw_ip_address" {
  description = "IP address of the client VPN endpoint"
  type        = string
}

variable "transit_gateway_hub_name" {
  description = "Name of the Transit Gateway to attach the VPN to"
  type        = string
}
variable "static_routes_only" {
  description = "Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP"
  type        = bool
  default     = false
}
variable "static_routes_destinations" {
  description = "List of CIDRs to be routed into the VPN tunnel."
  type        = list
  default     = []
}

# https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_VpnTunnelOptionsSpecification.html
variable "tunnel1_inside_cidr" {
  description = "A size /30 CIDR block from the 169.254.0.0/16 range"
  type        = string
}

variable "tunnel2_inside_cidr" {
  description = "A size /30 CIDR block from the 169.254.0.0/16 range"
  type        = string
}

variable "tunnel1_preshared_key" {
  description = "Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(_)"
  default     = null
  type        = string
}
variable "tunnel2_preshared_key" {
  description = "Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(_)"
  default     = null
  type        = string
}

variable "subnet_filters" {
  description = "List of maps selecting the subnet(s) for which the routing will be added"
  type = list(object({
    name   = string
    values = list(string)
  }))
  default = [
    {
      name   = "tag:Name"
      values = ["private"]
    }
  ]
}

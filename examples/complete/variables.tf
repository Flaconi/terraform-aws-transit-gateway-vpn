variable "allowed_account_id" {
  description = "AWS account ID for which this module can be executed"
  type        = string
}

variable "role_to_assume" {
  description = "IAM role name to assume (eg. ASSUME-ROLE-HUB)"
  type        = string
  default     = ""
}

variable "name" {
  description = "Generic name to be given to the provisioned resources"
  type        = string
}
variable "tags" {
  description = "Map of custom tags for the provisioned resources"
  type        = map(string)
  default     = {}
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

variable "transit_gateway_satellite_account_id" {
  description = "AWS account ID for which the module should share TGW resource"
  type        = string
}

variable "static_routes_only" {
  description = "Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP"
  type        = bool
  default     = false
}

variable "log_enabled" {
  description = "Whether to enable logging for the Transit Gateway VPN connection."
  type        = bool
  default     = false
}

variable "log_group_arn" {
  description = "ARN of an existing CloudWatch Log Group to use when logging is enabled. This module does not create or manage the log group."
  type        = string
  default     = null
}

variable "log_output_format" {
  description = "Output format for VPN logs when logging is enabled (for example: json)."
  type        = string
  default     = "json"

  validation {
    condition     = contains(["json", "text"], var.log_output_format)
    error_message = "log_output_format must be either \"json\" or \"text\"."
  }
}

variable "static_routes_destinations" {
  description = "List of CIDRs to be routed into the VPN tunnel."
  type        = list(string)
  default     = []
}

# https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_VpnTunnelOptionsSpecification.html
variable "tunnel1_inside_cidr" {
  description = "A size /30 CIDR block from the 169.254.0.0/16 range"
  type        = string
  default     = null
}

variable "tunnel2_inside_cidr" {
  description = "A size /30 CIDR block from the 169.254.0.0/16 range"
  type        = string
  default     = null
}

variable "tunnel1_preshared_key" {
  description = "Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(_)"
  type        = string
  default     = null
}

variable "tunnel2_preshared_key" {
  description = "Will be stored in the state as plaintext. Must be between 8 & 64 chars and can't start with zero(0). Allowed characters are alphanumeric, periods(.) and underscores(_)"
  type        = string
  default     = null
}

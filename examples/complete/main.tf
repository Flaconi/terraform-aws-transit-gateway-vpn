module "tgw" {
  source = "github.com/flaconi/terraform-aws-transit-gateway-hub.git?ref=v1.6.0"

  name = var.transit_gateway_hub_name

  aws_account_id_hub       = var.allowed_account_id
  aws_account_id_satellite = [var.transit_gateway_satellite_account_id]
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/test-vpn/${var.name}"
  retention_in_days = 1
}

module "vpn" {
  source = "../../"

  name = var.name

  cgw_bgp_asn    = var.cgw_bgp_asn
  cgw_ip_address = var.cgw_ip_address

  transit_gateway_hub_name       = var.transit_gateway_hub_name
  transit_gateway_hub_account_id = var.allowed_account_id
  static_routes_only             = var.static_routes_only
  log_enabled                    = true
  log_output_format              = "json"
  static_routes_destinations     = var.static_routes_destinations

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  ike_versions = ["ikev1", "ikev2"]
  phase1_dh_group_numbers = [
    2, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
  ]
  phase1_encryption_algorithms = [
    "AES256",
    "AES256-GCM-16",
  ]
  phase1_integrity_algorithms = [
    "SHA2-256",
    "SHA2-384",
    "SHA2-512",
  ]
  phase2_dh_group_numbers = [
    2, 5, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
  ]
  phase2_encryption_algorithms = [
    "AES256",
    "AES256-GCM-16",
  ]
  phase2_integrity_algorithms = [
    "SHA2-256",
    "SHA2-384",
    "SHA2-512",
  ]

  tags = var.tags

  depends_on = [module.tgw]
}

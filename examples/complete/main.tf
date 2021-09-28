# The Transit Gateway (hub) has already been created in AWS, as a fixture for
# this test case due to not being able to use 'depends_on' on Terraform modules
module "vpn" {
  source = "../../"

  providers = { aws = aws }

  role_to_assume     = var.role_to_assume
  allowed_account_id = var.allowed_account_id

  name = var.name

  cgw_bgp_asn    = var.cgw_bgp_asn
  cgw_ip_address = var.cgw_ip_address

  transit_gateway_hub_name   = var.transit_gateway_hub_name
  static_routes_only         = var.static_routes_only
  static_routes_destinations = var.static_routes_destinations

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = var.tags
}

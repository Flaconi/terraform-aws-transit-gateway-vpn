module "tgw" {
  source = "github.com/flaconi/terraform-aws-transit-gateway-hub.git?ref=v1.6.0"

  name = var.transit_gateway_hub_name

  aws_account_id_hub       = var.allowed_account_id
  aws_account_id_satellite = [var.transit_gateway_satellite_account_id]
}

module "vpn" {
  source = "../../"

  name = var.name

  cgw_bgp_asn    = var.cgw_bgp_asn
  cgw_ip_address = var.cgw_ip_address

  transit_gateway_hub_name       = var.transit_gateway_hub_name
  transit_gateway_hub_account_id = var.allowed_account_id
  static_routes_only             = var.static_routes_only
  static_routes_destinations     = var.static_routes_destinations

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = var.tags

  depends_on = [module.tgw]
}

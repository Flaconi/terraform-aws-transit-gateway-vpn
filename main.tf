resource "aws_customer_gateway" "this" {
  bgp_asn    = var.cgw_bgp_asn
  ip_address = var.cgw_ip_address
  type       = "ipsec.1"
  tags       = merge(var.tags, { Name = var.name })
}

resource "aws_vpn_connection" "this" {
  customer_gateway_id   = aws_customer_gateway.this.id
  type                  = "ipsec.1"
  transit_gateway_id    = data.aws_ec2_transit_gateway.this.id
  static_routes_only    = var.static_routes_only
  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key
  tags                  = merge(var.tags, { Name = var.name })
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = aws_vpn_connection.this.transit_gateway_attachment_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  transit_gateway_attachment_id  = aws_vpn_connection.this.transit_gateway_attachment_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.this.id
}

resource "aws_ec2_transit_gateway_route" "this" {
  count                          = var.static_routes_only ? length(var.static_routes_destinations) : 0
  destination_cidr_block         = element(var.static_routes_destinations, count.index)
  transit_gateway_attachment_id  = aws_vpn_connection.this.transit_gateway_attachment_id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.this.id
}

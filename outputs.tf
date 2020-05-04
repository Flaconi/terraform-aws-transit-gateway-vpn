output "vpn_gateway_id" {
  description = "ID of the VPN Gateway"
  value       = element(concat(aws_vpn_gateway.this.*.id, list("")), 0)
}

output "customer_gateway_id" {
  description = "ID of the Customer Gateway"
  value       = element(concat(aws_customer_gateway.this.*.id, list("")), 0)
}

output "vpn_connection" {
  description = "VPN connection details"
  value = {
    transit_gateway_attachment_id = element(concat(aws_vpn_connection.this.*.transit_gateway_attachment_id, list("")), 0)
    tunnel1_address               = element(concat(aws_vpn_connection.this.*.tunnel1_address, list("")), 0)
    tunnel1_cgw_inside_address    = element(concat(aws_vpn_connection.this.*.tunnel1_cgw_inside_address, list("")), 0)
    tunnel1_vgw_inside_address    = element(concat(aws_vpn_connection.this.*.tunnel1_vgw_inside_address, list("")), 0)
    tunnel2_address               = element(concat(aws_vpn_connection.this.*.tunnel2_address, list("")), 0)
    tunnel2_cgw_inside_address    = element(concat(aws_vpn_connection.this.*.tunnel2_cgw_inside_address, list("")), 0)
    tunnel2_vgw_inside_address    = element(concat(aws_vpn_connection.this.*.tunnel2_vgw_inside_address, list("")), 0)
  }
}

output "transit_gateway_id" {
  description = "ID of the used Transit Gateway"
  value       = module.tgw.transit_gateway_id
}

output "customer_gateway_id" {
  description = "ID of the Customer Gateway"
  value       = module.vpn.customer_gateway_id
}

output "vpn_connection" {
  description = "VPN connection details"
  value       = module.vpn.vpn_connection
}

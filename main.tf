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

  # Shared cryptographic options for both tunnels
  tunnel1_ike_versions                 = var.ike_versions
  tunnel1_phase1_dh_group_numbers      = var.phase1_dh_group_numbers
  tunnel1_phase1_encryption_algorithms = var.phase1_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.phase1_integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.phase2_dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.phase2_encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.phase2_integrity_algorithms

  tunnel2_ike_versions                 = var.ike_versions
  tunnel2_phase1_dh_group_numbers      = var.phase1_dh_group_numbers
  tunnel2_phase1_encryption_algorithms = var.phase1_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.phase1_integrity_algorithms
  tunnel2_phase2_dh_group_numbers      = var.phase2_dh_group_numbers
  tunnel2_phase2_encryption_algorithms = var.phase2_encryption_algorithms
  tunnel2_phase2_integrity_algorithms  = var.phase2_integrity_algorithms

  # Tunnel 1 options
  tunnel1_log_options {
    dynamic "cloudwatch_log_options" {
      for_each = var.log_enabled && var.log_group_arn != null && var.log_group_arn != "" ? [1] : []

      content {
        log_enabled       = true
        log_group_arn     = var.log_group_arn
        log_output_format = var.log_output_format
      }
    }
  }

  # Tunnel 2 options
  tunnel2_log_options {
    dynamic "cloudwatch_log_options" {
      for_each = var.log_enabled && var.log_group_arn != null && var.log_group_arn != "" ? [1] : []

      content {
        log_enabled       = true
        log_group_arn     = var.log_group_arn
        log_output_format = var.log_output_format
      }
    }
  }

  tags = merge(var.tags, { Name = var.name })
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

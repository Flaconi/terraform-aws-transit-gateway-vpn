data "aws_ram_resource_share" "this" {
  name           = var.transit_gateway_hub_name
  resource_owner = "SELF"
}

data "aws_ec2_transit_gateway" "this" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "owner-id"
    values = [var.allowed_account_id]
  }

  filter {
    name   = "transit-gateway-id"
    values = [data.aws_ram_resource_share.this.tags.transit-gateway-id]
  }
}

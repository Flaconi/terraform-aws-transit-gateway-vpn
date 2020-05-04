data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vgw_vpc_name_to_attach]
  }
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id

  dynamic "filter" {
    for_each = var.subnet_filters
    content {
      name   = filter.value["name"]
      values = filter.value["values"]
    }
  }
}

data "aws_route_table" "this" {
  count = length(data.aws_subnet_ids.this.ids)

  subnet_id = sort(data.aws_subnet_ids.this.ids)[count.index]
}

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

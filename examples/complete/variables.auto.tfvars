name = "test-vpn"

cgw_bgp_asn    = 65000
cgw_ip_address = "1.1.1.1"

transit_gateway_hub_name = "test-tgw-fixture"
static_routes_only       = true
static_routes_destinations = [
  "192.168.0.0/24",
  "192.168.1.0/24"
]

tunnel1_inside_cidr   = "169.254.6.0/30"
tunnel2_inside_cidr   = "169.254.7.0/30"
tunnel1_preshared_key = "heregoessomesupersecure.pre_shar3d_k3y"
tunnel2_preshared_key = "Andwehaveanother._0n3"


tags = {
  purpose = "testing-vpn"
}

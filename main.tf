locals {
  # AWS Resources
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  aws_vpn_gateway_id  = data.terraform_remote_state.vpc.outputs.aws_vpn_gateway_id
  aws_route_table_id  = data.terraform_remote_state.vpc.outputs.default_route_table_id

  # Azure VGW Resources
  public_ip_1         = data.terraform_remote_state.vgw.outputs.virtual_public_ip_1
  public_ip_2         = data.terraform_remote_state.vgw.outputs.virtual_public_ip_2
  vgw_name            = data.terraform_remote_state.vgw.outputs.virtual_network_gateway_name

  # Azure VNET Resources
  azure_cidr          = data.terraform_remote_state.vnet.outputs.cidr
}


resource "aws_customer_gateway" "customer_gateway_1" {
  bgp_asn = 65000

  # Using the previously fetched Azure's public IP
  ip_address = local.public_ip_1
  type       = "ipsec.1"

  tags = {
    Name = "customer_gateway_1"
  }
}

resource "aws_customer_gateway" "customer_gateway_2" {
  bgp_asn = 65000

  ip_address = local.public_ip_2
  type       = "ipsec.1"

  tags = {
    Name = "customer_gateway_2"
  }
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = local.vpc_id

  tags = {
    Name = "vpn_gateway"
  }
}

# We will use information from this piece to finish the Azure configuration on the next Step
resource "aws_vpn_connection" "vpn_connection_1" {
  vpn_gateway_id      = local.aws_vpn_gateway_id
  customer_gateway_id = aws_customer_gateway.customer_gateway_1.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "vpn_connection_1"
  }
}

# We will use information from this piece to finish the Azure configuration on the next Step
resource "aws_vpn_connection" "vpn_connection_2" {
  vpn_gateway_id      = local.aws_vpn_gateway_id
  customer_gateway_id = aws_customer_gateway.customer_gateway_2.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "vpn_connection_2"
  }
}

resource "aws_vpn_connection_route" "vpn_connection_route_1" {
  # Azure's vnet CIDR
  destination_cidr_block = local.azure_cidr
  vpn_connection_id      = aws_vpn_connection.vpn_connection_1.id
}

resource "aws_vpn_connection_route" "vpn_connection_route_2" {
  # Azure's vnet CIDR
  destination_cidr_block = local.azure_cidr
  vpn_connection_id      = aws_vpn_connection.vpn_connection_2.id
}

# The route teaching where to go to get to Azure's CIDR
resource "aws_route" "route_to_azure" {
  route_table_id = local.aws_route_table_id

  # Azure's vnet CIDR
  destination_cidr_block = local.azure_cidr
  gateway_id             = local.aws_vpn_gateway_id
}

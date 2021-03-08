terraform {
  required_version = ">= 0.14, < 0.15"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "network-${local.region}"
  location = var.region
}

resource "azurerm_virtual_network" "default" {
  name                = "vnet-${local.region}"
  resource_group_name = azurerm_resource_group.default.name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.default.location
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet-${local.region}"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = var.private_subnet_address_prefixes
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = var.gateway_address_prefixes
}

resource "azurerm_public_ip" "default" {
  name                = "public-ip-vpn-${local.region}"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  allocation_method   = "Dynamic"
}

# Comment Out to Save Money
resource "azurerm_virtual_network_gateway" "default" {
  name                = "vng-${local.region}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "Basic"

  ip_configuration {
    subnet_id            = azurerm_subnet.gateway.id
    public_ip_address_id = azurerm_public_ip.default.id
  }

  vpn_client_configuration {
    address_space = []
  }
}

resource "azurerm_local_network_gateway" "default" {
  name                = "lng-${local.region}"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  gateway_address     = var.gateway_address
  address_space       = var.gateway_address_space
  bgp_settings {
    asn                 = var.asn
    bgp_peering_address = var.bgp_peering_address
  }
}

# Comment Out and Rerun to Save Money
resource "azurerm_virtual_network_gateway_connection" "default" {
  name                       = "vngc-${local.region}"
  location                   = azurerm_resource_group.default.location
  resource_group_name        = azurerm_resource_group.default.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.default.id
  local_network_gateway_id   = azurerm_local_network_gateway.default.id

  shared_key                 = var.shared_key
}

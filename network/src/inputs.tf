variable gateway_address_space {
  type        = list
  description = "The list of string CIDRs representing the address spaces the gateway exposes."
}

variable asn {
  type        = number
  description = "The BGP speaker's ASN."
}

variable bgp_peering_address {
  type        = string
  description = "The BGP peering address and BGP identifier of this BGP speaker."
}

variable gateway_address {
  type        = string
  description = "The gateway IP address to connect with."
}

variable gateway_address_prefixes {
  type        = list
  description = "The list of string CIDRs representing the address prefixes assigned to the GatewaySubnet subnet created and attached to the virtual network."
}

variable private_subnet_address_prefixes {
  type        = list
  description = "The list of string CIDRs representing the address prefixes assigned to the private subnet created and attached to the virtual network."
}

variable region {
  type        = string
  description = "The Azure Region where resources should be created."
}

variable shared_key {
  type        = string
  default     = ""
  description = "The shared IPSec key to be used in creating the site-to-site VPN."
}

variable vnet_address_space {
  type        = list
  description = "The list of string CIDRs representing the address spaces to be assigned to the virtual network."
}


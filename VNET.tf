resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg1-test"
  location            = local.location
  resource_group_name = local.resource_group_name

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-test"
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["172.21.0.0/16"]
  dns_servers         = ["172.21.0.4", "172.21.0.5"]


  subnet {
    name             = "subnet1"
    address_prefixes = ["172.21.1.0/24"]

  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["172.21.2.0/24"]
    security_group   = azurerm_network_security_group.nsg1.id
  }
  tags = {
    environment = "local.tags"
  }
}

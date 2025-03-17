locals {
  resource_group_name = "RG1-Test"
  location            = "South Central US"
  virtual_network = {
    name          = "vnet-test"
    address_space = "172.21.0.0/16"
  }

  subnets = [
    {
      name            = "subnet1"
      address_prefixe = "[172.21.1.0/24]"
    },
    { name            = "subnet2"
      address_prefixe = "[172.21.2.0/24]"
    }

  ]


  tags = {
    environment = "TEST"
  }
}

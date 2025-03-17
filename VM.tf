# Data source to fetch existing VNet
data "azurerm_virtual_network" "vnet1" {
  name                = local.virtual_network.name
  resource_group_name = local.resource_group_name
}

# Data source to fetch existing Subnet
data "azurerm_subnet" "subnet1" {
  name                 = local.subnets[0].name
  virtual_network_name = data.azurerm_virtual_network.vnet1.name
  resource_group_name  = local.resource_group_name

}

# Create a network interface card

resource "azurerm_network_interface" "NIC1" {
  name                = "Test-nic"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal-test"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Virtual Machine
resource "azurerm_windows_virtual_machine" "VM1" {
  name                = "VM1-TEST"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "D2as_v4"
  admin_username      = "testuser1"
  admin_password      = "Testlogin@123"
  network_interface_ids = [
    azurerm_network_interface.NIC1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
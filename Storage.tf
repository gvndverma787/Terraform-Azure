# Create a Storage account
resource "azurerm_storage_account" "storagetest01" {
  name                     = "sanweustorage0145"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "local.tags"
  }
}

resource "azurerm_storage_container" "testcontainer" {
  name                  = "containertest"
  storage_account_id    = azurerm_storage_account.storagetest01.id
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.storagetest01]
}

resource "azurerm_storage_blob" "blob01" {
  name                   = "file1"
  storage_account_name   = azurerm_storage_account.storagetest01.name
  storage_container_name = azurerm_storage_container.testcontainer.name
  type                   = "Block"
  source                 = "main.tf"
  depends_on             = [azurerm_storage_container.testcontainer]

}




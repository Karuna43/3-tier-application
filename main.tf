resource "azurerm_resource_group" "test" {
  location = var.location
  name     = var.rg
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  size                = "Standard_B1ls"
  computer_name       = var.comp_name
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

module "postgresql" {
  source                       = "Azure/postgresql/azurerm"
  version                      = "3.2.0"
  resource_group_name          = azurerm_resource_group.test.name
  location                     = azurerm_resource_group.test.location
  server_name                  = "my-postgresql-server"
  sku_name                     = "B_Gen5_1"
  administrator_login          = "Iadmin"
  administrator_password = "mydatabse1234!"
  storage_mb                   = 5120
  backup_retention_days        = 7

}
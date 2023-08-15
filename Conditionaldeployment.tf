provider "azurerm" {
  subscription_id = "397c6e91-f10e-4520-a72e-4189dd912da2"
  client_id       = "2350c09f-4b5c-4cb4-979f-e4290bb0fa79"
  client_secret   = "32e157dd-a42b-4098-a765-b1b7211e797d"
  tenant_id       = "925397b0-926b-4c5b-9cfd-760186bd707a"
  features {}
}

resource "azurerm_resource_group" "siri-group" {
  name     = "siri-resource-group"
  location = "East US"
}

# Conditionally create a virtual machine based on a variable
variable "create_vm" {
  description = "Create virtual machine?"
  type        = bool
  default     = false
}

resource "azurerm_virtual_machine" "sirivm" {
  count = var.create_vm ? 1 : 0  # Create only if var.create_vm is true

  name                = "siri-vm"
  location            = azurerm_resource_group.urvrg.location
  resource_group_name = azurerm_resource_group.urvrg.name

  # Other VM configuration...

  os_profile {
    computer_name  = "sirivm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }
}

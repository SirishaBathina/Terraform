provider "azurerm" {
  subscription_id = "397c6e91-f10e-4520-a72e-4189dd912da2"
  client_id       = "2350c09f-4b5c-4cb4-979f-e4290bb0fa79"
  client_secret   = "32e157dd-a42b-4098-a765-b1b7211e797d"
  tenant_id       = "925397b0-926b-4c5b-9cfd-760186bd707a"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = "ap-remote-state-rg"
    storage_account_name  = "apstorageaccount"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "siri-resource-group"
  location = "East US"
}


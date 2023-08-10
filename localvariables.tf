terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {

  subscription_id="7e5dce23-8be8-4881-8214-c8fd9b80ee51"
  tenant_id = "afdeecf7-3eaf-4fe8-8066-aa259eaf0aec"
  client_id = "cfa961ea-d784-42f8-a8ce-965fafc0c330"
  client_secret = "2.H8Q~yoOmiGVg5eGwj~JH-BNql~t8mYIBz8Rb~G"
  features {
    
  }
}

locals {
  resource_group_name="app-grp"
  location="North Europe"
  virtual_network={
    name="app-network"
    address_space="10.0.0.0/16"
  }
}

resource "azurerm_resource_group" "appgrp" {
  name     = local.resource_group_name
  location = local.location
}
resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.virtual_network.address_space
  

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnetB"
    address_prefix = "10.0.2.0/24"
    
  }
}

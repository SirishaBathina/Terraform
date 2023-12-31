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
  subnet=[

    {
      name="subnetA"
      address_prefix="10.0.0.0/24"
    },
    {
      name="subnetB"
      address_prefix="10.0.0.0/24"
    }
  ]
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
  

  
  depends_on = [ azurerm_resource_group.appgrp ]
}

resource "azurerm_subnet" "subnetA" {
  name                 = local.subnet[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network
  address_prefixes     = [local.local.subnet[0].address_prefix]
}


resource "azurerm_subnet" "subnetB" {
  name                 = local.subnet[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network
  address_prefixes     = [local.local.subnet[1].address_prefix]
  depends_on = [ azurerm_virtual_network.appnetwork ]
}

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

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "North Europe"
}

resource "azurerm_storage_account" "storageaccountsiri" {
  name                     = "storageaccountsiri"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "storageaccountsiri"
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = "storageaccountsiri"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "main.tf"
}

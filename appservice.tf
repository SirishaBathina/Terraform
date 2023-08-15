provider "azurerm" {
  subscription_id = "397c6e91-f10e-4520-a72e-4189dd912da2"
  client_id       = "2350c09f-4b5c-4cb4-979f-e4290bb0fa79"
  client_secret   = "32e157dd-a42b-4098-a765-b1b7211e797d"
  tenant_id       = "925397b0-926b-4c5b-9cfd-760186bd707a"
  features {}
}


resource "azurerm_resource_group" "sirinewrg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "sirinewappserviceplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.sirinewrg.location
  resource_group_name = azurerm_resource_group.sirinewrg.name
  kind                = "App"
   sku {
    tier = "Basic"
    size = "B1"
  }
 
}

resource "azurerm_app_service" "sirinewappservice" {
  name                = var.app_service_name
  location            = azurerm_resource_group.sirinewrg.location
  resource_group_name = azurerm_resource_group.sirinewrg.name
  app_service_plan_id = azurerm_app_service_plan.sirinewappserviceplan.id
  site_config {
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "development"
  }

  connection_string {
    name  = "MyDatabase"
    type  = "SQLServer"
    value = "Server=mydbserver.database.windows.net;Database=mydb;User Id=myuser;Password=mypassword;"
  }
}

output "urv_app_service_url" {
  value = azurerm_app_service.urvnewappservice.default_site_hostname
}

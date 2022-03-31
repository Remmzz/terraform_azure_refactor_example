provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}
 
data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "dev" {
  name     =  "devrg"
  location = var.location
}
 
#Create Storage account
resource "azurerm_storage_account" "dev" {
  name                = "darwin1devstorage"
  resource_group_name = azurerm_resource_group.dev.name
 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
 
  static_website {
    index_document = "index.html"
  }
}
 
#Add index.html to blob storage
resource "azurerm_storage_blob" "dev" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.dev.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}


#Create Resource Group
resource "azurerm_resource_group" "prod" {
  name     = "prodrg"
  location = var.location
}
 
#Create Storage account
resource "azurerm_storage_account" "prod" {
  name                = "darwin1prodstorage"
  resource_group_name = azurerm_resource_group.prod.name
 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
 
  static_website {
    index_document = "index.html"
  }
}
 
#Add index.html to blob storage
resource "azurerm_storage_blob" "prod" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.prod.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

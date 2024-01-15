# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg_4_storageaccounts"
#     storage_account_name = "tfstrgacct"
#     container_name       = "tfstate"
#     key                  = "network.tfstate"
#   }
# }
# provider "azurerm" {
#   features {}

  # subscription_id   = "4fdbc0b9-1163-442d-96e8-0edc10214845"
  # tenant_id         = "be834229-c698-4960-a9c3-0fe2746998b0"
  # client_id         = "496514d5-ef37-4893-9fd3-fa4a1e52c7f3"
  # client_secret     = "OjX8Q~qjj7wwHdlzg1fsg~sIqyTKHosaX6qZRdyh"
# }

# ------------------
# Resource Group
# ------------------
# resource "azurerm_resource_group" "eternal" {
#   count    = (var.environment == "dev" || var.environment == "prod") ? 1 : 0
#   name     = "${var.prefix}cloud-resources-eternal"
#   location = var.location
#   tags     = var.rgtags
# }
# ------------------
# resource group for this environment
# ------------------
# resource "azurerm_resource_group" "digicloud" {
#   name     = "${var.prefix}-resources-${var.environment}"
#   location = var.location
#   tags     = var.rgtags
# }
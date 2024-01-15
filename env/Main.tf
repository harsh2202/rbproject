terraform {
  backend "azurerm" {
    resource_group_name  = "rg_4_storageaccounts"
    storage_account_name = "tfstrgacct"
    container_name       = "tfstate"
    key                  = "all_resources.tfstate"
  }
}
provider "azurerm" {
  features {}

  # subscription_id   = "4fdbc0b9-1163-442d-96e8-0edc10214845"
  # tenant_id         = "be834229-c698-4960-a9c3-0fe2746998b0"
  # client_id         = "496514d5-ef37-4893-9fd3-fa4a1e52c7f3"
  # client_secret     = "OjX8Q~qjj7wwHdlzg1fsg~sIqyTKHosaX6qZRdyh"
}

module "network" {
  source              = "../modules/network"
  location            = var.location
  resource_group_name = "${var.prefix}-${var.env}-rg"
  prefix              = var.prefix
}

module "dbs" {
  source              = "../modules/dbs"
  location            = var.location
  resource_group_name = "${var.prefix}-${var.env}-db-rg"
#  prefix              = var.prefix

}

module "aks" {
  source              = "../modules/aks"
  location            = var.location
  resource_group_name = "${var.prefix}-${var.env}-aks-rg"
  prefix              = var.prefix
  aks_cluster_name = "${var.prefix}-${var.env}-aks"
  client_id =   ""
  client_secret = ""
  dns_prefix =  ""

}

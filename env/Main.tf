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

  # subscription_id   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # tenant_id         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # client_id         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # client_secret     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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

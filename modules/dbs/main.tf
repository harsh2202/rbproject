resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_subnet" "pgsql" {
  name = "pe"
  resource_group_name = "digicloud-dev-rg"
  virtual_network_name = "digicloud-dev-vnet"
}

data "azurerm_subnet" "pe" {
  name = "db"
  resource_group_name = "digicloud-dev-rg"
  virtual_network_name = "digicloud-dev-vnet"
}

data "azurerm_client_config" "current" {}

data "azurerm_private_dns_zone" "akvprivatelink" {
  name = "privatelink.vaultcore.azure.net"
  resource_group_name = "azcloud-resources-${var.env}"
}

data "azurerm_private_dns_zone" "acrprivatelink" {
  name = "privatelink.azurecr.io"
  resource_group_name = "azcloud-resources-${var.env}"
  
}
data "azurerm_private_dns_zone" "pgsqlprivatelink" {
  name = "privatelink.postgres.database.azure.com"
  resource_group_name = "azcloud-resources-${var.env}"
}

# ------------------
# generate admin password for shared PGSQL instances
# ------------------
resource "random_password" "pgsqladminpassword" {
  length           = 12
  special          = true
  override_special = "_%@"
}

# ------------------
# shared digi Flex Server instance 
# ------------------
resource "azurerm_postgresql_flexible_server" "digicloud" {
  name                          = "${var.prefix}pgsqlflex${var.env}"
  resource_group_name           = resource.azurerm_resource_group.rg.name
  location                      = var.location
  version                       = "12"
  administrator_login           = var.pgsqladminlogin
  administrator_password        = random_password.pgsqladminpassword.result  #azurerm_key_vault_secret.pgsqladminpassword.value
  storage_mb                    = 131072
  sku_name                      = "GP_Standard_D2ds_v4"
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  # delegated_subnet_id           = data.azurerm_subnet.subnetpostgres2.id
  private_dns_zone_id           = data.azurerm_private_dns_zone.pgsqlprivatelink.id
  tags                          = var.tags
  maintenance_window {
    day_of_week  = 2
    start_hour   = 19
    start_minute = 30
  }
  lifecycle {
    ignore_changes = [
      zone,
    ]
  }
}
resource "azurerm_postgresql_flexible_server_configuration" "digicloud" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.digicloud.id
  value     = "pg_trgm,pgcrypto,unaccent,uuid-ossp"
}
# resource "azurerm_monitor_diagnostic_setting" "digipgsqlflex_diagnostics" {
#   name               = "${var.prefix}pgsqlflex${var.env}-diagnostic"
#   target_resource_id = azurerm_postgresql_flexible_server.digicloud.id
#   log_analytics_workspace_id = resource.azurerm_log_analytics_workspace.dbs.id
#   log {
#     category = "PostgreSQLLogs"
#     enabled  = true
#     retention_policy {
#       enabled = true
#       days    = 7
#     }
#   }
#   metric {
#     category = "AllMetrics"
#     enabled  = true

#     retention_policy {
#       enabled = true
#       days    = 7
#     }
#   }
# }
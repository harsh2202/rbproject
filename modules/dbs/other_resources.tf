##############################
# Log Analytics              #
##############################

# resource "azurerm_log_analytics_workspace" "dbs" {
#   name                = "${var.prefix}loganalytics-dbs"
#   resource_group_name = resource.azurerm_resource_group.rg.name
#   location            = var.location
#   sku                 = "Free"
#   retention_in_days   = 7
#   tags                = var.tags
# }

##############################
# AKV                        #
##############################

resource "azurerm_key_vault" "digicloud" {
  name                        = "${var.prefix}-kv-${var.env}"
  location                    = var.location
  resource_group_name         = resource.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id    
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  tags                        = var.tags
  sku_name                    = "standard"
}
resource "azurerm_private_endpoint" "digicloudakv" {
  name                = "${var.prefix}-kv-${var.env}-endpoint"
  resource_group_name = resource.azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${var.prefix}-kv-${var.env}-servicdiginection"
    private_connection_resource_id = azurerm_key_vault.digicloud.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.akvprivatelink.id]
  }
}
# ------------------
# AKV diagnostics
# ------------------
# resource "azurerm_monitor_diagnostic_setting" "digicloud-kv" {
#   count                      = (var.env == "prod") ? 1 : 0
#   name                       = "${var.prefix}-kv-${var.env}-diag"
#   target_resource_id         = azurerm_key_vault.digicloud.id
#   #log_analytics_workspace_id = azurerm_log_analytics_workspace.dbs.id
#   log {
#     category = "AuditEvent"
#     enabled  = true
#     retention_policy {
#       enabled = true
#       days    = 7
#     }
#   }
#   log {
#     category = "AzurePolicyEvaluationDetails"
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
# ------------------
# AKV policy for SP
# ------------------
# resource "azurerm_key_vault_access_policy" "digicloud-sp" {
#   key_vault_id = azurerm_key_vault.digicloud.id
#   tenant_id    = var.tenant_id
#   object_id    =  data.azurerm_client_config.current.object_id
#   key_permissions = [
#     "Get","Backup", "Create", "Decrypt", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Encrypt", "Decrypt", "Sign", "Verify",
#   ]
#   secret_permissions = [
#     "Get", "Set", "Backup", "Delete", "List", "Purge", "Recover", "Restore",
#   ]
#   storage_permissions = [
#     "Get", "Backup", "Delete", "DeleteSAS", "GetSAS", "List",
#   ]
#   certificate_permissions = [
#     "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageIssuers", "Purge", "SetIssuers", "Update",
#   ]
# }

# ------------------
# PUBLIC STATIC IPs
# ------------------
resource "azurerm_public_ip" "app_rb" {
  name                = "${var.prefix}-ip-app_rb-${var.env}"
  resource_group_name = resource.azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.prefix}-${var.env}-app_rb"
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# ------------------
# ACR
# ------------------
resource "azurerm_container_registry" "digicloud" {
  count                   = (var.env == "dev" || var.env == "prod") ? 1 : 0
  name                    = "${var.prefix}cr${var.env}"
  resource_group_name     = resource.azurerm_resource_group.rg.name
  location                = var.location
  sku                     = "Premium"
  zone_redundancy_enabled = true
  tags                    = var.tags
  admin_enabled           = true
}
data "azurerm_container_registry" "digicloud" {
  name                = "${var.prefix}crprod"
  resource_group_name = resource.azurerm_resource_group.rg.name
}
resource "azurerm_private_endpoint" "digicloudacr" {
  name                = "${var.prefix}cr${var.env}-endpoint"
  resource_group_name = resource.azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${var.prefix}cr${var.env}-servicdiginection"
    private_connection_resource_id = data.azurerm_container_registry.digicloud.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.acrprivatelink.id]
  }
}
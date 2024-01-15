variable "location" {
  description = "Azure region"
  default     = "southeastasia"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "prefix" {
  description = "Resource prefix"
  type = string
  default     = "digicloud"
}

variable "resource_group_name" {
  description = "Resource Group name"
  default     = "digicloud-dev-db-rg"
}

variable "app_databases" {
  description = "app DBs that will be pre-created"
  type        = set(string)
  default     = ["LicenseServer", "HealthMonitoring", "FileHosterDB", "appAnyWhere", "CustomizationService"]
}

variable "appdb_adminlogin" {
  type        = string
  description = "Name of admin login for app DB"
  default     = "dbadmin"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Any tags that should be present on the resources"
}

variable "pgsqladminlogin" {
  type        = string
  description = "Name of admin login for shared single server digi DB (pw is read from AKV)"
  default     = "dbadmin"
}

variable "tenant_id" {
  default = "be834229-c698-4960-a9c3-0fe2746998b0"
  
}
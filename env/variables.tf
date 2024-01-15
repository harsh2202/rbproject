# ---------
# General #
# ---------
variable "location" {
  type        = string
  description = "Location/Region that will be used for resources"
  default     = "southeastasia"
}

variable "prefix" {
  type        = string
  description = "The prefix for the resources created in the specified Azure Resource Group"
  default     = "digicloud"
}

variable "env" {
  type        = string
  description = "The environment name that will be used for tagging"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Any tags that should be present on the resources"
}

variable "rgtags" {
  type        = map(string)
  default     = {}
  description = "tags for resource groups"
}

#################      VMSS      #################3

# variable "resource_group_name" {
#   description = "Name of the resource group where VMSS will be created"
#   type        = string
# }

# variable "sku" {
#   description = "SKU for the Virtual Machine Scale Set"
#   type        = string
# }

# variable "instances" {
#   description = "Number of instances in the Virtual Machine Scale Set"
#   type        = number
# }

# variable "admin_username" {
#   description = "Admin username for the VMSS instances"
#   type        = string
# }

# variable "admin_password" {
#   description = "Admin password for the VMSS instances"
#   type        = string
# }

# variable "os_disk_type" {
#   description = "OS disk type for the VMSS instances"
#   type        = string
# }

# variable "subnet_id" {
#   description = "ID of the subnet where VMSS instances will be deployed"
#   type        = string
# }

# variable "backend_address_pool_id" {
#   description = "ID of the backend address pool associated with the load balancer"
#   type        = string
# }

# variable "boot_diagnostics_storage_uri" {
#   description = "URI for the storage account used for boot diagnostics"
#   type        = string
# }

# variable "zones" {
#   description = "Availability zones for the VMSS instances"
#   type        = list(string)
# }

# variable "custom_script" {
#   description = "Custom script to be executed on VMSS instances"
#   type        = string
# }

# variable "health_script" {
#   description = "Health script to be executed on VMSS instances"
#   type        = string
# }

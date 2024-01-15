variable "location" {
  description = "Azure region"
  default     = "southeastasia"
}

variable "env" {
  description = "Environment"
  default     = "dev"
}

variable "prefix" {
  description = "Resource prefix"
  type = string
  default     = "digicloud"
}

variable "resource_group_name" {
  description = "Resource Group name"
  default     = "digicloud-dev-rg"
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
  default     = ["aks", "db", "pe", "storage"]
}

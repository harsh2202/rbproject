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
  default     = "digicloud-dev-aks-rg"
}

variable "aks_cluster_name" {
  description = "Name of the AKS Cluster"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
  default     = "southeastasia"
}

variable "node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Size of the AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "client_id" {
  description = "Azure AD service principal client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure AD service principal client secret"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
}

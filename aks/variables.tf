
variable "resource_group_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-all-rg"
}

variable "aks_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-aks"

}

variable "aks_sku_tier" {
  type    = string
  default = "Standard"
}


variable "aks_zones" {
  type    = list(number)
  default = [1]
}

variable "aks_identity" {
  type    = string
  default = "SystemAssigned"

}

variable "location" {
  type    = string
  default = "eastus"

}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}


variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}
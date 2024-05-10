
variable "resource_group_name_all" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-all-rg"
}


# variable "resource_group_name_aks_secondary" {
#   type    = string
#   default = "az-eastus-bsp-dev-newobw-all-rg-secondary"
# }


variable "ssh_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-ssh"

}
variable "aks_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-aks"

}

variable "acr_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-acr"

}

variable "sqlServer_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-sqls"
}

variable "sqlDatabase_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-dbsql"
}


variable "aks_sku_tier" {
  type    = string
  default = "Standard"
}

variable "acr_sku" {
  type    = string
  default = "Premium"
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
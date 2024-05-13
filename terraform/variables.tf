
#<-------------------- LOCATION ---------------------->
variable "location" {
  type    = string
  default = "eastus"

}

#<-------------------- RESOURCE GROUP ---------------------->
variable "resource_group_name_all" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-all-rg"
}

variable "resource_group_name_seguridad" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-all-seguridad"
}


#<-------------------- AKS ---------------------->
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

variable "node_count" {
  type    = number
  default = 1
}


variable "username" {
  type    = string
  default = "azureadmin"
}


variable "ssh_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-ssh"

}

#<-------------------- ACR ---------------------->
variable "acr_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-acr"

}

variable "acr_sku" {
  type    = string
  default = "Premium"
}

variable "acr_private_endpoint_name" {
  type    = string
  default = "private-endpoint-acr"

}

#<-------------------- SQL ---------------------->

variable "sqlServer_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-sqls"
}

variable "sqlDatabase_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-dbsql"
}

variable "sql_private_endpoint_name" {
  type    = string
  default = "private-endpoint-sql"

}

#<-------------------- KEY VAULT ---------------------->

variable "keyvault_name" {
  type    = string
  default = "az-eastus-bsp-dev-newobw-kv"
}


variable "akv_private_endpoint_name" {
  type    = string
  default = "private-endpoint-akv"

}








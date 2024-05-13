
locals {
  default_node_pool = {
    name                  = "agentpool"
    vm_size               = "Standard_D4s_v3"
    enable_auto_scaling   = false
    enable_node_public_ip = false
    os_sku                = "Ubuntu"
    os_disk_size_gb       = 512
  }

  network_profile = {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }

  virtual_network = {
    name          = "az-eAstus-bsp-newobw-vnet-backend"
    address_space = "10.0.0.0/8"
  }

  subnets = {
    name           = "az-eastus-bsp-dev-newobw-snet-aks"
    address_prefix = "10.240.0.0/16"
  }

  database = {
    collation                       = "SQL_Latin1_General_CP1_CI_AS"
    license_type                    = "LicenseIncluded"
    max_size_gb                     = 500
    read_scale                      = false
    sku_name                        = "GP_Gen5_4"
    zone_redundant                  = false
    storage_account_type            = "Local"
    version                         = "12.0"
    administrator_login             = "admin123"
    administrator_login_password    = "6EW5SSHR9BVt"
    minimum_tls_version             = "1.2"
    sample_name                     = "AdventureWorksLT"
    dns_zone_name                   = "privatelink.database.windows.net"
    private_service_connection_name = "private-serviceconnection"
    subresource_names               = "sqlServer"
    is_manual_connection            = false
    private_dns_zone_group          = "sql-dns-zone-group"
    virtual_network_link            = "sql-link"
  }

  container_registry = {

    admin_enabled                 = false
    public_network_access_enabled = false


    network_rule_bypass_option       = "None"
    role_definition_name             = "AcrPull"
    skip_service_principal_aad_check = true
    dns_zone_name                    = "privatelink.azurecr.io"
    virtual_network_link             = "acr-link"
    private_service_connection_name  = "private-serviceconnection"
    subresource_names                = "registry"
    is_manual_connection             = false
    private_dns_zone_group           = "acr-dns-zone-group"
  }

}


# locals {
#   location = "eastus"
# #   aks = {
#     dns_name = "dns-fitting-urchin"
#   }


#   subnets = {
#       name           = "AZ-EASTUS-BSP-DEV-NEWOBW-SNET-AKS"
#       address_prefix = "10.0.1.0/24"
#     }


# }
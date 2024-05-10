
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
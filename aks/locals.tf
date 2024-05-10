
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
}


# locals {
#   location = "eastus"
# #   aks = {
#     dns_name = "dns-fitting-urchin"
#   }

#   virtual_network = {
#     name          = "AZ-EASTUS-BSP-NEWOBW-VNET-BACKEND"
#     address_space = "10.0.0.0/16"
#   }

#   subnets = {
#       name           = "AZ-EASTUS-BSP-DEV-NEWOBW-SNET-AKS"
#       address_prefix = "10.0.1.0/24"
#     }


# }s
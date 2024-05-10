

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.location
  name                = var.aks_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id
  node_resource_group = "mc-${azurerm_resource_group.rg.name}"
  sku_tier = var.aks_sku_tier
  identity {
    type = var.aks_identity
  }

  default_node_pool {
    name       = local.default_node_pool.name
    vm_size    = local.default_node_pool.vm_size
    node_count = var.node_count
    enable_auto_scaling = local.default_node_pool.enable_auto_scaling
    zones = var.aks_zones
    enable_node_public_ip = local.default_node_pool.enable_node_public_ip
    os_sku = local.default_node_pool.os_sku
    os_disk_size_gb = local.default_node_pool.os_disk_size_gb
    # vnet_subnet_id = azurerm_subnet.sbnt01.id


  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }

  network_profile {
    network_plugin    = local.network_profile.network_plugin
    load_balancer_sku = local.network_profile.load_balancer_sku
    network_policy    = local.network_profile.network_policy
    # service_cidr = "10.2.0.0/16"
    # dns_service_ip    = "10.2.0.10"
  }
}
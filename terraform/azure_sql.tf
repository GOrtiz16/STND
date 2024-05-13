# resource "azurerm_mssql_server" "sqlServer" {
#   name                         = var.sqlServer_name
#   resource_group_name          = azurerm_resource_group.rg_all.name
#   location                     = var.location
#   version                      = local.database.version
#   administrator_login          = local.database.administrator_login
#   administrator_login_password = local.database.administrator_login_password
#   minimum_tls_version          = local.database.minimum_tls_version


# }

# resource "azurerm_mssql_database" "sqlDatabase" {
#   name                 = var.sqlDatabase_name
#   server_id            = azurerm_mssql_server.sqlServer.id
#   collation            = local.database.collation
#   license_type         = local.database.license_type
#   max_size_gb          = local.database.max_size_gb
#   read_scale           = local.database.read_scale
#   sku_name             = local.database.sku_name
#   zone_redundant       = local.database.zone_redundant
#   storage_account_type = local.database.storage_account_type
#   sample_name          = local.database.sample_name

# }


# resource "azurerm_private_dns_zone" "az_sql_dns_zone" {
#   name                = local.database.dns_zone_name
#   resource_group_name = azurerm_resource_group.rg_all.name
# }



# resource "azurerm_private_endpoint" "az_sql_endpoint" {
#   name                = var.sql_private_endpoint_name
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg_all.name
#   subnet_id           = azurerm_subnet.sbnt01.id

#   private_service_connection {
#     name                           = local.database.private_service_connection_name
#     private_connection_resource_id = azurerm_mssql_server.sqlServer.id
#     subresource_names              = [local.database.subresource_names]
#     is_manual_connection           = local.database.is_manual_connection
#   }

#   #   ip_configuration {
#   #     name                          = "ip-config"
#   #     private_ip_address            = "10.240.0.33"
#   # }

#   private_dns_zone_group {
#     name                 = local.database.private_dns_zone_group
#     private_dns_zone_ids = [azurerm_private_dns_zone.az_sql_dns_zone.id]
#   }
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "az_sql_vnet_link" {
#   name                  = local.database.virtual_network_link
#   resource_group_name   = azurerm_resource_group.rg_all.name
#   private_dns_zone_name = azurerm_private_dns_zone.az_sql_dns_zone.name
#   virtual_network_id    = azurerm_virtual_network.vnet01.id
# }
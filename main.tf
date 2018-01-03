provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

resource "azurerm_resource_group" "osrg" {
  name     = "${format("%s-%s-%s",var.openshift_azure_resource_prefix,var.openshift_azure_resource_group,var.openshift_azure_resource_suffix)}"
  location = "${var.openshift_azure_region}"
}

resource "random_id" "randomId" {
  byte_length = 4
}

resource "azurerm_storage_account" "osstorageregistry" {
  name                = "${var.openshift_azure_resource_prefix}sa${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.osrg.name}"
  depends_on          = ["azurerm_resource_group.osrg"]
  location            = "${azurerm_resource_group.osrg.location}"
 # account_type        = "Standard_LRS"
   account_tier          = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "osstoragepv" {
  name                = "${var.openshift_azure_resource_prefix}pv${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.osrg.name}"
  depends_on          = ["azurerm_resource_group.osrg"]
  location            = "${azurerm_resource_group.osrg.location}"
  account_tier          = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_resource_group" "aks-rg2" {
  name = "${var.rg-name}"
  location = "${var.rg-location}"

  tags = {
    "env" = "k8sdev"
    "demotag" = "demotf"
  }
}
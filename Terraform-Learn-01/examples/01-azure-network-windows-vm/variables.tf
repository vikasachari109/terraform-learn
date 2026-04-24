variable "rg-name" {
    type = string
    description = "used for nameing the resource group"
}
variable "rg-location" {
  type = string
  description = "used for the RG location"
  default = "eastus"
}
variable "prefix" {
  type = string
  description = "used for the prefix name"
}
variable "vnet_cidr_prefix" {
  type = string
  description = "used for CIDR prefix name"
}
variable "subnet_cidr_prefix" {
  type = string
  description = "used for the subnet prefix name"
}
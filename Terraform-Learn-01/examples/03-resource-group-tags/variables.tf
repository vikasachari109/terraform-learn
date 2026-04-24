variable "rg-name" {
    type = string
    description = "name of the rg in the azure"
    default = "aks-rg1-tf"
}
variable "rg-location" {
    type = string
    description = "location of the rg in the azure"
    default = "Central US"
}
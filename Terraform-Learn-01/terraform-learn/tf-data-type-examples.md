



varibale "sa-name"{
    type = string
    description = eqbe
    
    validation {
        condition = containts(["dev", "test", "satge"], var.sa-name)
        error_message = "allwed = dev, test, stage"
    }
    validation {
        condition = length(sa-name) >= 3 && length(sa-name) <=24
        error_message = "it should me mini 3 and max 24"
    }

}

--- This example creates multiple resource groups using a map.

variable "rg-rg" {
    type = map(string)
    description = qecioqewnc
    default = {
        dev = "East us"
        test = "west us"
        stage = "south west"
    }
}

resorce "rg" "" {
    for_each = var.rg-rg

    name = each.key
    location = each.value
}

--- This example creates multiple storage accounts dynamically. using count

varible "sa-count" {
    count = 3
}

resource "sa" "sa-new" {
    count = var.sa-count
    name  =  "mystorage{count.index}"
    reg   = "reg-dev"
    loc   = var.loc
}

--- This example loops through a list to create multiple virtual machines.


varibale "vm_names" {
    type = list(string)
    defualt = ["vm1", "vm2", "vm3"]
}

resource "vm" "vm-name" {
    count = length(var.vm_names)
    name  = var.vm_names[count.index]
    res_g = 
    loc   =
    vm_si = 
    os_pro {
        computer_name = var.vm-name[count.index]
        adin = "u123"
        pass = "pas123"
    }
}

--- Using for Expression to Modify a List

variable "names" {
  default = ["alice", "bob", "charlie"]
}

output "uppercase_names" {
  value = [for name in var.names : upper(name)]
}

--- 

variable "names" {
  default = ["alice", "bob", "charlie"]
}

output "uppercase_names" {
  value = [for name in var.names : upper(name)]
}
--- 

variable "vm_names" {
  default = ["vm1", "vm2", "vm3"]
}

output "vm_map" {
  value = { for idx, name in var.vm_names : name => "vm-${idx + 1}" }
}

---

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = "East US"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]
}

variable "subnets" {
  type = map(string)
  default = {
    "subnet1" = "10.0.1.0/24"
    "subnet2" = "10.0.2.0/24"
  }
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = "my-resource-group"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}


---

variable "vm_names" {
  type    = list(string)
  default = ["web1", "web2", "web3"]
}

resource "azurerm_virtual_machine" "vm" {
  count                 = length(var.vm_names)
  name                  = var.vm_names[count.index]
  location              = "East US"
  resource_group_name   = "my-resource-group"
  vm_size               = "Standard_B2s"
  network_interface_ids = ["<NIC-ID>"]

  os_profile {
    computer_name  = var.vm_names[count.index]
    admin_username = "adminuser"
    admin_password = "Password123!"
  }
}

---

variable "storage_account_name" {
  type = string

  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters."
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = "my-resource-group"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


--- 

variable "backend_pools" {
    type = map(string)
    default = {
      "pool1" = "10.0.1.4"
      "pool2" = "10.0.2.4"
    }
  }
  
  resource "azurerm_application_gateway" "appgw" {
    name                = "my-appgw"
    location            = "East US"
    resource_group_name = "my-resource-group"
  
    backend_address_pool {
      for_each = var.backend_pools
      name     = each.key
      ip_addresses = [each.value]
    }
  }
  

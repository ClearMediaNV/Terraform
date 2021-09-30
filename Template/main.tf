# Terraform Block
terraform {
  required_version = "0.13.5"
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.0.0"
    }
  }
}

# Provider Block
provider "vcd" {
  user = var.UserName
  password = var.UserPassword
  auth_type = "integrated"
  org = var.OrgName
  vdc = var.VdcName 
  url = "https://my.bizzcloud.be/api"
}

# Resource Blocks
resource "vcd_vapp" "vApp" {
  name = var.vAppName
}

resource "vcd_vapp_network" "vAppNet" {
  vapp_name = vcd_vapp.vApp.name
  name  = var.vAppNetworkName
  gateway = "192.168.13.1"
  netmask = "255.255.255.0"
  dns1 = "195.238.2.21"
  dns2 = "8.8.8.8"
  static_ip_pool {
    start_address = "192.168.13.100"
    end_address = "192.168.13.199"
  }
}

resource "vcd_vapp_org_network" "vAppOrgNet" {
  vapp_name = vcd_vapp.vApp.name
  org_network_name  = var.VdcNetworkName
}

resource "vcd_vapp_vm" "vm1" {
  vapp_name = vcd_vapp.vApp.name
  name = var.vm1Name
  computer_name = var.vm1Name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.TemplateWindows2019
  memory = 4096
  cpus = 1
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vAppNet.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.100"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}

resource "vcd_vapp_vm" "vm2" {
  vapp_name = vcd_vapp.vApp.name
  name = var.vm2Name
  computer_name = var.vm2Name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name  = "Public_Catalog"
  template_name = var.TemplateWindows2019
  memory = 6144
  cpus = 2
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vAppNet.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.101"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}

resource "vcd_vm_internal_disk" "vm2_disk1" {
  vapp_name = vcd_vapp.vApp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 1
}

resource "vcd_vm_internal_disk" "vm2_disk2" {
  vapp_name = vcd_vapp.vApp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 2
  depends_on = [ vcd_vm_internal_disk.vm2_disk1 ]
}

resource "vcd_vapp_vm" "vm3" {
  vapp_name = vcd_vapp.vApp.name
  name = var.vm3Name
  computer_name = var.vm3Name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.TemplateFireboxV
  memory = 1024
  cpus = 1
  cpu_cores = 1
  network {
    name = var.VdcNetworkName
    type = "org"
    ip_allocation_mode = "POOL"
    adapter_type = "VMXNET3"
    is_primary = true
  }
  network {
    name = vcd_vapp_network.vAppNet.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.254"
    adapter_type = "VMXNET3"
    is_primary = false
  }
}

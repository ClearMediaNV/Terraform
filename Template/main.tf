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
  user = var.user_name
  password = var.user_password
  auth_type = "integrated"
  org = var.org_name
  vdc = var.vdc_name 
  url = "https://my.bizzcloud.be/api"
}

# Resource Blocks
resource "vcd_vapp" "vapp" {
  name = var.vapp_name
}

resource "vcd_vapp_network" "vapp_net" {
  vapp_name = vcd_vapp.vapp.name
  name  = var.vapp_network_name
  gateway = "192.168.13.1"
  netmask = "255.255.255.0"
  dns1 = "195.238.2.21"
  dns2 = "8.8.8.8"
  static_ip_pool {
    start_address = "192.168.13.100"
    end_address = "192.168.13.199"
  }
}

resource "vcd_vapp_org_network" "vapp_org_net" {
  vapp_name = vcd_vapp.vapp.name
  org_network_name  = var.vdc_network_name
}

resource "vcd_vapp_vm" "vm1" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm1_name
  computer_name = var.vm1_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.TemplateWindows2019
  memory = 4096
  cpus = 1
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.100"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}

resource "vcd_vapp_vm" "vm2" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm2_name
  computer_name = var.vm2_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name  = "Public_Catalog"
  template_name = var.TemplateWindows2019
  memory = 6144
  cpus = 2
  cpu_cores = 1
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.101"
    adapter_type = "VMXNET3"
    is_primary = true
  }
}

resource "vcd_vm_internal_disk" "vm2_disk1" {
  vapp_name = vcd_vapp.vapp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 1
}

resource "vcd_vm_internal_disk" "vm2_disk2" {
  vapp_name = vcd_vapp.vapp.name
  vm_name = vcd_vapp_vm.vm2.name
  bus_type = "paravirtual"
  size_in_mb = "5120"
  bus_number = 0
  unit_number = 2
  depends_on = [ vcd_vm_internal_disk.vm2_disk1 ]
}

resource "vcd_vapp_vm" "vm3" {
  vapp_name = vcd_vapp.vapp.name
  name = var.vm3_name
  computer_name = var.vm3_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = "Public_Catalog"
  template_name = var.TemplateFireboxV
  memory = 1024
  cpus = 1
  cpu_cores = 1
  network {
    name = var.vdc_network_name
    type = "org"
    ip_allocation_mode = "POOL"
    adapter_type = "VMXNET3"
    is_primary = true
  }
  network {
    name = vcd_vapp_network.vapp_net.name
    type = "vapp"
    ip_allocation_mode = "MANUAL"
    ip = "192.168.13.254"
    adapter_type = "VMXNET3"
    is_primary = false
  }
}

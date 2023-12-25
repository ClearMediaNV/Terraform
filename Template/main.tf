# Terraform Block
terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.10.0"
    }
  }
}

# Provider Block
provider "vcd" {
  user = local.user_name
  password = local.user_password
  auth_type = "integrated"
  org = local.org_name
  vdc = local.vdc_name 
  url = "https://my.bizzcloud.be/api"
}

# Data Block
data "vcd_org" "org" {
  name = local.org_name
}

# Resource Blocks
resource "vcd_vapp" "vapp" {
  name = local.vapp_name
}

resource "vcd_vapp_network" "vapp_net" {
  vapp_name = vcd_vapp.vapp.name
  name  = local.vapp_network_name
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
  org_network_name  = local.vdc_network_name
}

resource "vcd_vapp_vm" "vm1" {
  vapp_name = vcd_vapp.vapp.name
  name = local.vm1_name
  computer_name = local.vm1_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = local.template_catalog_name
  template_name = local.template_windows_name
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
  name = local.vm2_name
  computer_name = local.vm2_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name  = local.template_catalog_name
  template_name = local.template_windows_name
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
  name = local.vm3_name
  computer_name = local.vm3_name
  power_on = false
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  catalog_name = local.template_catalog_name
  template_name = local.template_watchguard_name
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
 network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }
  network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }
  network {
    type = "none"
	ip_allocation_mode = "NONE"
	adapter_type = "VMXNET3"
	is_primary = false
  }  
}

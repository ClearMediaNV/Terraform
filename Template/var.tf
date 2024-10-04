variable "org_name" {
	type = string
	default = "Cleartoso"
	}
variable "user_name" {
	type = string
	default = "YourUserName"
	}
variable "user_password" {
	type = string
	default = "YourUserPassword"
	sensitive = true
	}
variable "vdc_name" {
	type = string
	default = "vDC-Cleartoso-Machelen"
	}
variable "vdc_network_name" {
	type = string
	default = "orgnet-Direct-Cleartoso"
	}
variable "vapp_name" {
	type = string
	default = "vApp-xyz"
	}
variable "vapp_network_name" {
	type = string
	default = "vAppNet-xyz"
	}
variable "vm1_name" {
	type = string
	default = "DC"
	}
variable "vm2_name" {
	type = string
	default = "RDS"
	}
variable "vm3_name" {
	type = string
	default = "FireboxV"
	}
variable "template_catalog_name" {
	type = string
	default = "Public_Catalog"
	}
variable "template_windows_name" {
	type = string
	default = "Win2022Template"
	}
variable "template_watchguard_name" {
	type = string
	default = "FireboxVTemplate"
	}

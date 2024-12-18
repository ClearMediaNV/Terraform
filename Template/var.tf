variable "org_name" {
	type = string
	default = "OrgName"
	}
variable "user_name" {
	type = string
	default = "UserName"
	}
variable "user_password" {
	type = string
	default = "UserPassword"
	sensitive = true
	}
variable "vdc_name" {
	type = string
	default = "vDC-OrgName-Machelen"
	}
variable "vdc_network_name" {
	type = string
	default = "orgnet-Direct-OrgName"
	}
variable "vapp_name" {
	type = string
	default = "vApp-Demo"
	}
variable "vapp_network_name" {
	type = string
	default = "vAppNet-Demo"
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

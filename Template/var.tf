variable "OrgName"	{
	type = string
	default = "Cleartoso"
	}
variable "UserName" {
	type = string
	default = "terraform"
	}
variable "UserPassword" {
	type = string
	default = "????????????????????????"
	}
variable "VdcName" {
	type = string
	default = "vDC-Cleartoso-Machelen"
	}
variable "VdcNetworkName" {
	type = string
	default = "orgnet-Direct-Cleartoso"
	}
variable "vAppName" {
	type = string
	default = "vApp-xyz"
	}
variable "vAppNetworkName" {
	type = string
	default = "vAppNet-xyz"
	}
variable "vm1Name" {
	type = string
	default = "DC"
	}
variable "vm2Name" {
	type = string
	default = "RDS"
	}
variable "vm3Name" {
	type = string
	default = "FireboxV"
	}
variable "TemplateWindows2016" {
	type = string
	default = "Win2016 Version 1.9"
	}
variable "TemplateWindows2019" {
	type = string
	default = "Win2019 Version 1.9"
	}
variable "TemplateFireboxV" {
	type = string
	default = "FireboxV v12.6.4U1 Template"
	}

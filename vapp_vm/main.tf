terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.4.0"
    }
  }
}

variable "VM_NUMBERS" {
  default = 1
}

variable "VAPP_NAME" {
  type = string
}

variable "NETWORK_NAME" {
  type = list
}

variable "METADATA" {
  type = map
  default = {}
}

variable "VAPP_VM_NAME" {}
variable "CATALOG_NAME" {}
variable "TEMPLATE_NAME" {}
variable "MEMORY" {}
variable "CPUS" {}
variable "CPU_CORES" {}
variable "INITSCRIPT" {
  default = ""
}
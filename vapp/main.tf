terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.5"
    }
  }
}

variable "VAPP_NAME" {
  type = string
}

variable "NETWORK_NAME" {
  type = list
}
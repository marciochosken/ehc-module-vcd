terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.5"
    }
  }
}

provider "vcd" {
}
resource "vcd_vapp_vm" "default" {
  count = var.VM_NUMBERS

  vapp_name     = var.VAPP_NAME
  name          = format("%s-%g", var.VAPP_VM_NAME, count.index)
  computer_name = format("%s-%g", var.VAPP_VM_NAME, count.index)
  catalog_name  = var.CATALOG_NAME
  template_name = var.TEMPLATE_NAME
  memory        = var.MEMORY
  cpus          = var.CPUS
  cpu_cores     = var.CPU_CORES
  power_on      = true

  metadata = var.METADATA

  dynamic "network" {
    for_each = var.NETWORK_NAME
    content {
      type               = "org"// var.NETWORK_TYPE
      name               = network.value
      ip_allocation_mode = "POOL"
      is_primary         = network.value == element(var.NETWORK_NAME, 0) ? true : false
    }
  }

  guest_properties = {
    "guest.hostname"   = format("%s-%g", var.VAPP_VM_NAME, count.index)
  }

  customization {
      force                      = var.FORCE_CUSTOMIZATION
      enabled                    = true
      allow_local_admin_password = true
      auto_generate_password     = true
      initscript                 = var.INITSCRIPT
  }
}
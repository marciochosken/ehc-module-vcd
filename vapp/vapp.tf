resource "vcd_vapp" "default" {
  name = var.VAPP_NAME
}

resource "vcd_vapp_org_network" "networks" {
  count = length(var.NETWORK_NAME)
  vapp_name = vcd_vapp.default.name
  org_network_name = element(var.NETWORK_NAME, count.index)

  depends_on = [ vcd_vapp.default ]
}
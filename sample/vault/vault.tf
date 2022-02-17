data "template_file" "init-sample" {
  template = "${file("${path.cwd}/init_script.sh")}"

  vars = {
    ztnetwork   = ""
  }
}

module "vapp_vault" {
  source = "../../vapp/"

  VAPP_NAME    = "vault"
  NETWORK_NAME = [ "" ]
}

module "vm_vault" {
  source = "../../vapp_vm/"

  VM_NUMBERS          = 1
  VAPP_NAME           = "vault"
  NETWORK_NAME        = [ "" ]
  VAPP_VM_NAME        = "vault"
  CATALOG_NAME        = "EHC-IMAGES"
  TEMPLATE_NAME       = "Ubuntu Server 20.04 LTS"
  MEMORY              = 4096
  CPUS                = 2
  CPU_CORES           = 1
  //FORCE_CUSTOMIZATION = true
  INITSCRIPT          = "${data.template_file.init-sample.rendered}"
  METADATA            = {
      env = "test"
      role = "vault"
    }

  depends_on = [ module.vapp_vault ]
}
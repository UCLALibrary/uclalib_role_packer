# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "rhel8" {
  boot_command = [
    "<up><wait><tab><wait> ",
    "inst.text <wait>",
    "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg <wait>",
    "ipv6.disable=1 <wait>",
    "${var.vm_boot_string} <wait>",
    "<enter><wait>"
  ]
  boot_order           = "disk,cdrom,floppy"
  boot_wait            = "10s"
  cluster              = "${var.vsphere_cluster}"
  convert_to_template  = "${var.convert_to_template}"
  CPUs                 = "${var.vm_cpu_num}"
  datacenter           = "${var.vsphere_datacenter}"
  datastore            = "${var.vsphere_datastore}"
  disk_controller_type = ["pvscsi"]
  folder               = "${var.vsphere_folder}"
  guest_os_type        = "rhel8_64Guest"
  http_content = {
    "/ks.cfg" = templatefile("${var.role_path}/files/ks/rhel8.cfg.pkrtpl.hcl",
      {
        rhsm_organization   = "${var.rhsm_organization}",
        rhsm_activation_key = "${var.rhsm_activation_key}",
        rootpw              = "${var.rootpw}",
        ssh_public_key      = "${var.ssh_public_key}",
      }
    )
  }
  iso_checksum = "${var.iso_checksum}"
  iso_url      = "${var.iso_url}"
  network_adapters {
    network      = "${var.vsphere_network}"
    network_card = "vmxnet3"
  }
  notes                = "Built via Packer."
  password             = "${var.vsphere_password}"
  RAM                  = "${var.vm_mem_size}"
  RAM_reserve_all      = false
  ssh_private_key_file = "${var.ssh_private_key_file}"
  ssh_username         = "root"
  storage {
    disk_size             = "${var.vm_disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere_user}"
  vcenter_server = "${var.vsphere_server}"
  vm_name        = "${var.vm_short_name}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build

build {
  provisioner "ansible" {
    inventory_directory = "${var.inventory_directory}"
    playbook_file = "${var.playbook_file}"
    user          = "root"
    extra_arguments = [
      "--diff",
      "--verbose",
      // "${var.extra_vars}",
    ]
  }
  sources = ["source.vsphere-iso.rhel8"]
}

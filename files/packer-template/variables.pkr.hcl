# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# Read the variables type constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.

variable "iso_url" {
  type    = string
}

variable "iso_checksum" {
  type    = string
}

# https://rancher.com/docs/rancher/v2.6/en/installation/requirements/#k3s-kubernetes
variable "vm_cpu_num" {
  type    = string
}

# minimum RHEL8 size
# https://access.redhat.com/articles/rhel-limits#minimum-required-disk-space-4
variable "vm_disk_size" {
  type    = string
}

# https://rancher.com/docs/rancher/v2.6/en/installation/requirements/#k3s-kubernetes
variable "vm_mem_size" {
  type    = string
}

variable "vm_short_name" {
  type = string
}

variable "vm_ip" {
  type    = string
}

variable "vsphere_cluster" {
  type    = string
}

variable "vsphere_datacenter" {
  type    = string
}

variable "vsphere_datastore" {
  type    = string
}

variable "vsphere_folder" {
  type    = string
}

variable "vsphere_network" {
  type    = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_server" {
  type    = string
}

variable "vsphere_user" {
  type    = string
}

# Kickstart Variables
variable "rhsm_organization" {
  type      = string
  sensitive = true
}

variable "rhsm_activation_key" {
  type      = string
  sensitive = true
}

variable "rootpw" {
  type      = string
  sensitive = true
}

variable "ssh_private_key_file" {
  type    = string
}

variable "convert_to_template" {
  type = string
}

variable "role_path" {
  type = string
}

variable "vm_boot_string" {
  type = string
  default = ""
}

variable "ssh_public_key" {
  type = string
}

variable "playbook_file" {
  type = string
}

// variable "extra_vars" {
//   type = string
// }

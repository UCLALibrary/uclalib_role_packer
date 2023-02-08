# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# Read the variables type constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.

variable "iso_url" {
  type    = string
  default = "http://rhn.library.ucla.edu/os/rhel8/rhel-8.6-x86_64-boot.iso"
}

variable "iso_checksum" {
  type    = string
  default = "file:http://rhn.library.ucla.edu/os/rhel8/SHA256SUMS"
}

# https://rancher.com/docs/rancher/v2.6/en/installation/requirements/#k3s-kubernetes
variable "vm_cpu_num" {
  type    = string
  default = "1"
}

# minimum RHEL8 size
# https://access.redhat.com/articles/rhel-limits#minimum-required-disk-space-4
variable "vm_disk_size" {
  type    = string
  default = "10000"
}

# https://rancher.com/docs/rancher/v2.6/en/installation/requirements/#k3s-kubernetes
variable "vm_mem_size" {
  type    = string
  default = "1024"
}

variable "vm_name" {
  type = string
}

variable "vm_ip" {
  type    = string
  default = ""
}

variable "vsphere_cluster" {
  type    = string
  default = "HPE Synergy"
}

variable "vsphere_datacenter" {
  type    = string
  default = "Library Information Technology"
}

variable "vsphere_datastore" {
  type    = string
  default = "NetApp8200-RHEL"
}

variable "vsphere_folder" {
  type    = string
  default = "LinuxTemplates"
}

variable "vsphere_network" {
  type    = string
  default = "VLAN-596"
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_server" {
  type    = string
  default = "vc.library.ucla.edu"
}

variable "vsphere_user" {
  type    = string
  default = "ad\\rancher"
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
  default   = "!!"
  sensitive = true
}

variable "ssh_private_key_file" {
  type    = string
  default = "~/.ssh/id_rsa"
}

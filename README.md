UCLALib Role Packer
===================

Build a VMware virtual machine or template with HashiCorp's Packer. Enables
IaaC by pulling hardware definitions from Ansible group / host vars. Comes
packed with reasonable defaults.

Requirements
------------

* Packer, by HashiCorp
* VMware vSphere
  * vsphere user with proper [privileges][privileges]
* RHEL ISO
  * May work with CentOS or Rocky Linux, but untested
* RedHat Subscription highly encouraged
* Local user with firewall adjustment permissions

Role Variables
--------------

Mandatory variables are marked *MANDATORY*

### Packer BUilder for VMware vSphere

* `convert_to_template`: (boolean)
  * default: false

#### Boot Configuration

* `vm_boot_string`: (string)
  * Default: *empty*
* `vm_ip`:
  * default:  'dhcp'

#### Http directory configuration

* `packer_http_port`: (string/tcp)
  * default: '8000-9000/tcp'
  * Default value based on Packer defaults

#### Connection Configuration

* `vsphere_server`: (string/hostname)
  * *MANDATORY*
* `vsphere_user`: (string/username)
  * *MANDATORY*
* `vsphere_password`: (string/plaintext password)
  * *MANDATORY*
* `vsphere_datacenter`: (string)
  * default: *empty*

#### Hardware Configuration

* `vm_cpu_num`: (string/integer)
  * default: '1'
* `vm_mem_size`: (string/integer)
  * RAM in MB
  * default: '1536'

#### Location Configuration

* `vm_name`: (string)
  * *MANDATORY*
  * Name of VM or template to create
  * Can be either short, or FQDN
  * Assumes `ansible_domain` if short

* `vsphere_vm_folder`: (string)
  * default: *empty*
* `vsphere_template_folder`: (string)
  * default: *empty*
* `vsphere_folder`: (string)
  * derived from:
    * `vsphere_vm_folder`
    * `vsphere_template_folder`
    * `convert_to_template`

* `vsphere_cluster`: (string)
  * *MANDATORY*
* `vsphere_datastore`: (string)
  * *MANDATORY*

#### ISO Configuration

* `iso_url`: (string/uri)
  * default: 'file:file://./rhel-8.iso'
* `iso_checksum`: (string/checksum)
  * default: 'none'
  * Highly recommended to set

#### Create Configuration

##### Network Adapter Configuration

* `vsphere_network`: (string)
  * *MANDATORY*

##### Storage Configuration

* `vm_disk_size`: (string/integer)
  * Primary disk size in MB
  * default: '10000'

#### Communicator configuration

* `ssh_private_key`: (string/pathname)
  * SSH private key, used for provisioning
  * default: '~/.ssh/id_rsa'

### Kickstart Variables

* `rhsm_organization`: (string)
  * default: *empty*
* `rhsm_activation_key`: (string)
  * default: *empty*
* `rootpw`: (string/encrypted password)
  * Password for root user of vm/template being built
  * default: '!!'
* `ssh_public_key`: (string/pathname)
  * See `ssh_public_key_value`
  * SSH key used for provisioning
  * default: '~/.ssh/id_rsa.pub'
* `ssh_public_key_value`: (string)
  * Added to `/root/.ssh/authorized_keys` of vm/template being built
  * derived from `ssh_public_key`

### Packer Ansible Provisioner

* `playbook_file`: (string/pathname)
  * relative to `files/playbooks`
  * Ansible playbook used to provision the vm/template
  * default: 'no-op.yml'

### Packer Invocation

* `force_build`: (boolean)
  * default: false

Example Playbook
----------------

This role does not rely upon the requested system to exist in the Ansible
inventory. A wrapper playboook is required to make the temporary addition, and
call the role.

```yaml
---

- name: 'uclalib_role_packer.yml'
  hosts: 'localhost'
  gather_facts: false
  connection: 'local'

  tasks:
    - name: 'Assert vm_name is set'
      assert:
        that: vm_name is defined
    - name: 'Add host'
      add_host:
        name: '{{ vm_name }}'

- name: 'uclalib_role_packer.yml pt 2'
  hosts: '{{ vm_name }}'
  gather_facts: false

  pre_tasks:
    - name: 'Gathering Facts'
      setup:
        gather_subset: '!all'
      connection: 'local'

  roles:
    - name: 'uclalib_role_packer'
      connection: 'local'
```

Firewalld + Policy Kit
----------------------

The ansible user needs to be able to manipulate the firewall. This role avoids
the use of `become:` to provide privilege escallation.

The following Policy Kit rule will allow the ansible user to modify the
firewall without requiring `become:` or invoking the role as root.

`/etc/polkit-1/rules.d/10-ansible-firewalld.rules`

```json
/* Allow ansible user to manipulate firewalld */

polkit.addRule(function(action, subject) {
    if (action.id == "org.fedoraproject.FirewallD1.config" &&
        subject.user == "ansible") {
        return polkit.Result.YES;
    }
});
```

License
-------

[The 3-Clause BSD License][LICENSE]

Author Information
------------------

John H. Robinson, IV  
Powell Library, UCLA  
<jhriv@ucla.edu>

Copyright 2023 Regents of the University of California

<!-- Footnotes -->

[privileges]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso#required-vsphere-privileges
[LICENSE]: LICENSE

<!-- markdownlint-disable-file MD003 -->

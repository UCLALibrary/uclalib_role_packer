# UCLA Library RHEL 10 Kickstart
# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/automatically_installing_rhel/kickstart-commands-and-options-reference
# https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/pdf/automatically_installing_rhel/Red_Hat_Enterprise_Linux-10-Automatically_installing_RHEL-en-US.pdf
# https://web.archive.org/web/20260130153609/https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/pdf/automatically_installing_rhel/Red_Hat_Enterprise_Linux-10-Automatically_installing_RHEL-en-US.pdf

# 21.2. PACKAGE SELECTION IN KICKSTART

# 21.2.1. Package selection section
%packages --ignoremissing
@Core
openssh-server
open-vm-tools
-plymouth
%end

# 21.3. SCRIPTS IN KICKSTART FILE

# 21.3.1. %pre script

# 21.3.2. %pre-install script

# 21.3.3. %post script
# %post
# echo ${ vm_fqdn } > /etc/hostname
# install \
#   --mode=0700 \
#   --directory \
#   /root/.ssh
# install \
#   --mode=0600 \
#   /dev/null /root/.ssh/authorized_keys
# echo '${ ssh_public_key }'\
#   > /root/.ssh/authorized_keys
# dnf clean all
# %end

# 22.2. KICKSTART COMMANDS FOR INSTALLATION PROGRAM CONFIGURATION AND FLOW CONTROL
eula --agreed
firstboot --disabled
nfs --server=devsupport.in.library.ucla.edu --dir=/LX/isos/redhat/10.1
reboot
rhsm --organization=${rhsm_organization} --activation-key=${rhsm_activation_key}
text --non-interactive

# 22.3. KICKSTART COMMANDS FOR SYSTEM CONFIGURATION
firewall --enabled --ssh
keyboard us
lang en_US.UTF-8
rootpw --iscrypted --allow-ssh '${ rootpw }'
selinux --permissive
services --enabled=NetworkManager,sshd
skipx
sshkey --username=root '${ ssh_public_key }'
timezone America/Los_Angeles --utc

# 22.4. KICKSTART COMMANDS FOR NETWORK CONFIGURATION
#network --bootproto dhcp --noipv6
network --hostname=${ vm_fqdn } --noipv6

# 22.5. KICKSTART COMMANDS FOR HANDLING STORAGE
clearpart --all --initlabel
zerombr
bootloader --location mbr
autopart --type=plain --fstype=xfs --nohome --noboot--noswap 

# 22.6. KICKSTART COMMANDS FOR ADDONS SUPPLIED WITH THE RHEL INSTALLATION PROGRAM

# 22.7. KICKSTART COMMANDS FOR SYSTEM RECOVERY

# rescue

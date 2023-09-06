# UCLA Library RHEL 8 Kickstart
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_8_installation/kickstart-commands-and-options-reference_installing-rhel-as-an-experienced-user

# B.2. Kickstart commands for installation program configuration and flow control
#cdrom
eula --agreed
firstboot --disabled
nfs --server=devsupport.in.library.ucla.edu --dir=/LX/isos/redhat/8.6
reboot
rhsm --organization=${rhsm_organization} --activation-key=${rhsm_activation_key}
text --non-interactive

# B.3. Kickstart commands for system configuration
firewall --disabled
keyboard us
lang en_US.UTF-8
#repo --name=epel/x86_64 --metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-8&arch=$basearch&infra=$infra&content=$contentdir --install
rootpw --iscrypted ${rootpw}
selinux --permissive
services --enabled=NetworkManager,sshd
skipx
timezone UTC

# B.4. Kickstart commands for network configuration
#network --bootproto dhcp --noipv6

# B.5. Kickstart commands for handling storage
autopart --fstype=xfs --nohome --type=lvm --noswap
bootloader --location mbr
clearpart --all --initlabel
zerombr

# B.6. Kickstart commands for addons supplied with the RHEL installation program

# B.7. Commands used in Anaconda


# Package Selection

%packages --ignoremissing --excludedocs
@Core
openssh-server
open-vm-tools
-plymouth
%end

# Pre-install Script

# Post-install Script

%post
echo ${ vm_fqdn } > /etc/hostname
install \
  --mode=0700 \
  --directory \
  /root/.ssh
install \
  --mode=0600 \
  /dev/null /root/.ssh/authorized_keys
echo '${ ssh_public_key }'\
  > /root/.ssh/authorized_keys
yum clean all
%end

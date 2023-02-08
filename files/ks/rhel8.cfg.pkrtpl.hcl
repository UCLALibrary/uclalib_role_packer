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
autopart --fstype=xfs --nohome --nolvm --noswap
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
install \
  --mode=0700 \
  --directory \
  /root/.ssh
install \
  --mode=0600 \
  /dev/null /root/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA8p5P2vu7uKPJaaQBaMx50RBUqkHp'\
'DghWGQ5qUtrIcqIUkeRuFsvGY7b+s8/puLMyHolJvIQeGd+lfmWYOq0LQogmEYuIpdDYg'\
'VOHKk0yZh34RTHulPVUKYtf5cWvnAab/rMnrAqbyZ9c8vGc0XrVuYllz3NCBNKpLSVIrl'\
'CIswLJei37BBYaWIuw2eoFdafEVy2tdkLs0V4Xef5sQj3JXOQSRO2h2pgdfHVkQuNDWaO'\
'7BdR4ubUDUMfIuj8rHehEUzA8R5/3FcxiiNo24miA5+KAojx3CMsg9X5P8IVXYkbH6eq7'\
'neqx/KGSVvK2uqU+7gIyAHKM2jBFxjy3ivLQseJ9AojXStqlTfceaqfC3Lawg/SmJKh6A'\
'rYBVuWH7rvwlJfJyWyrw1PCs4VAlX9wRepIf55oqwTcw1Xtc4/+tEk7OJh1x/36N1H6De'\
'jexnOVEwwHPpM8V9UApl3u3YXjTQ3SL7WSKr2rHNCksV6/MdwKniPoVps1+IctG99GbSM'\
'6FMNEn9Sd1wqq3pNN4sOjVe2KAv0SufYbK3VdDPe2oFrqDCtbCZaYWqO6bOcoDePfTXnX'\
'xArFFvcStbn6WmUCc95uyWLK1kJlUe62ecTVMvlw/4VSgco5PlxyRD6JGop3dgCXaWNI7'\
'GGRdd2sSQXSJGytXOmWzkJ64GFZm4z47Pk= ansible@lit264v'\
  > /root/.ssh/authorized_keys
yum clean all
%end

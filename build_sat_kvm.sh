#!/bin/bash

### Quick and nasty to build the Satellite VM as the Vagrant box for RHEL 7.4 is busted

## Build the Satellite VM

export source_image=/downloads/rhel-guest-image-7.4-263.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/satellite-boot.qcow2
export ip_address=192.168.122.51
export subnet_mask=255.255.255.0
export gateway=192.168.122.1
export dns_1=192.168.122.1
export vm_name=telstra-media-build_satellite
export host_name=satellite

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr2

qemu-img create -f qcow2 -b ${source_image} ${target_disk} 16G
virt-customize -a ${target_disk} --run-command "hostname ${host_name}"
virt-customize -a ${target_disk} --run-command "echo ${host_name} >/etc/hostname"
virt-customize -a ${target_disk} --run-command 'echo > /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo DEVICE="eth0"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo ONBOOT="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo TYPE="Ethernet"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo PEERDNS="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo IPV6INIT="no"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command "echo IPADDR=${ip_address}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo NETMASK=${subnet_mask}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo GATEWAY=${gateway}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo DNS1=${dns_1}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command 'touch /etc/cloud/cloud-init.disabled'
virt-install --memory 8192  --vcpus 4  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}
sleep 10
virsh set-user-password ${vm_name} root redhat123

qemu-img create -f qcow2 /var/lib/libvirt/images/satellite-data.qcow2 200G
virsh attach-disk --domain ${vm_name} --source /var/lib/libvirt/images/satellite-data.qcow2 --target vdb --persistent --live --driver qemu --subdriver qcow2

## Build First Capsule

export source_image=/downloads/rhel-guest-image-7.4-263.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/capsule-pri-boot.qcow2
export ip_address=192.168.122.52
export subnet_mask=255.255.255.0
export gateway=192.168.122.1
export dns_1=192.168.122.1
export vm_name=telstra-media-build_capsule-pri
export host_name=capsule-pri

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr2

qemu-img create -f qcow2 -b ${source_image} ${target_disk} 16G
virt-customize -a ${target_disk} --run-command "hostname ${host_name}"
virt-customize -a ${target_disk} --run-command "echo ${host_name} >/etc/hostname"
virt-customize -a ${target_disk} --run-command 'echo > /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo DEVICE="eth0"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo ONBOOT="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo TYPE="Ethernet"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo PEERDNS="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo IPV6INIT="no"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command "echo IPADDR=${ip_address}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo NETMASK=${subnet_mask}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo GATEWAY=${gateway}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo DNS1=${dns_1}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command 'touch /etc/cloud/cloud-init.disabled'
virt-install --memory 8192  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}
sleep 10
virsh set-user-password ${vm_name} root redhat123

qemu-img create -f qcow2 /var/lib/libvirt/images/capsule-pri-data.qcow2 200G
virsh attach-disk --domain ${vm_name} --source /var/lib/libvirt/images/capsule-pri-data.qcow2 --target vdb --persistent --live

## Build Second Capsule

export source_image=/downloads/rhel-guest-image-7.4-263.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/capsule-sec-boot.qcow2
export ip_address=192.168.122.53
export subnet_mask=255.255.255.0
export gateway=192.168.122.1
export dns_1=192.168.122.1
export vm_name=telstra-media-build_capsule-sec
export host_name=capsule-sec

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr2

qemu-img create -f qcow2 -b ${source_image} ${target_disk} 16G
virt-customize -a ${target_disk} --run-command "hostname ${host_name}"
virt-customize -a ${target_disk} --run-command "echo ${host_name} >/etc/hostname"
virt-customize -a ${target_disk} --run-command 'echo > /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo DEVICE="eth0"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo ONBOOT="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo TYPE="Ethernet"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo PEERDNS="yes"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command 'echo IPV6INIT="no"  >> /etc/sysconfig/network-scripts/ifcfg-eth0'
virt-customize -a ${target_disk} --run-command "echo IPADDR=${ip_address}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo NETMASK=${subnet_mask}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo GATEWAY=${gateway}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command "echo DNS1=${dns_1}  >> /etc/sysconfig/network-scripts/ifcfg-eth0"
virt-customize -a ${target_disk} --run-command 'touch /etc/cloud/cloud-init.disabled'
virt-install --memory 8192  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}
sleep 10
virsh set-user-password ${vm_name} root redhat123

qemu-img create -f qcow2 /var/lib/libvirt/images/capsule-sec-data.qcow2 200G
virsh attach-disk --domain ${vm_name} --source /var/lib/libvirt/images/capsule-sec-data.qcow2 --target vdb --persistent --live




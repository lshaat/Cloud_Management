#!/bin/bash

### Quick and nasty to build the cfme virtual appliances

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr2

export source_image=/downloads/cfme-rhevm-5.9.0.22-1.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/cfme_db_1.qcow2
export vm_name=telstra-media-build_cfme_db_1
export host_name=cfme_db_1

cp -p ${source_image} ${target_disk}
virt-install --memory 4096  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}

qemu-img create -f qcow2 /var/lib/libvirt/images/${host_name}-data.qcow2 50G
virsh attach-disk ${vm_name} --source /var/lib/libvirt/images/${host_name}-data.qcow2 --target vdb --persistent --driver qemu --subdriver qcow2

export source_image=/downloads/cfme-rhevm-5.9.0.22-1.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/cfme_db_2.qcow2
export vm_name=telstra-media-build_cfme_db_2
export host_name=cfme_db_2

cp -p ${source_image} ${target_disk}
virt-install --memory 4096  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}

qemu-img create -f qcow2 /var/lib/libvirt/images/${host_name}-data.qcow2 50G
virsh attach-disk ${vm_name} --source /var/lib/libvirt/images/${host_name}-data.qcow2 --target vdb --persistent --driver qemu --subdriver qcow2

export source_image=/downloads/cfme-rhevm-5.9.0.22-1.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/cfme_app_1.qcow2
export vm_name=telstra-media-build_cfme_app_1
export host_name=cfme_app_1

cp -p ${source_image} ${target_disk}
virt-install --memory 4096  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}

export source_image=/downloads/cfme-rhevm-5.9.0.22-1.x86_64.qcow2
export target_disk=/var/lib/libvirt/images/cfme_app_2.qcow2
export vm_name=telstra-media-build_cfme_app_2
export host_name=cfme_app_2

cp -p ${source_image} ${target_disk}
virt-install --memory 4096  --vcpus 2  --os-variant rhel7 --disk path=${target_disk},device=disk,bus=virtio,format=qcow2 --import --noautoconsole --vnc --bridge virbr2 --name ${vm_name}

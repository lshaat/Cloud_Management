#!/bin/bash

action=$1

if [ ! $1 ]
then
	echo "Specify what you want me to do.."
	exit 1
fi

case $action in 
	start)
		for VM in $(sudo virsh list --all |grep telstra-media-build |awk '{print $2}')
		do
			echo "Starting ${VM}..."
			sudo virsh start ${VM}
		done
	;;
	stop)
                for VM in $(sudo virsh list |grep telstra-media-build |awk '{print $2}')
                do
                        echo "Stopping ${VM}..."
                        sudo virsh shutdown ${VM}
                done
	;;
	*)
		echo "Unknown Action"
		exit 2
	;;
esac


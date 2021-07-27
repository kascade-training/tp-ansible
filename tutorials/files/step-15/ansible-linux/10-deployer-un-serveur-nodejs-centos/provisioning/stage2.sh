#!/bin/bash
echo "include virt-scripts in the PATH"
export PATH=$PATH:~/virt-scripts/ ; echo "PATH=$PATH:~/virt-scripts/" >> ~/.bashrc
echo "Launch three guests"
for x in app1 app2 db ; do quick-launch.sh $x centos7 ; done
echo "Add the libvirt bridge as nameserver"
sed -i '1 i\nameserver 192.168.122.1' /etc/resolv.conf
echo "Check the guests"
virsh list
echo "Get disk usage"
du -h /var/lib/libvirt/images/*
echo "Test the connectivity to the hosts"
sleep 60 ; for x in app1 app2 db ; do ping -c10 $x ; done

#!/bin/bash
echo "Go to the home folder"
cd
echo "Install Git"
apt-get -y install git
echo "Clone the virt-script repo on Github"
git clone https://github.com/goffinet/virt-scripts
echo "Go to the virt-scripts folder"
cd virt-scripts
echo "Install the requirements"
./autoprep.sh

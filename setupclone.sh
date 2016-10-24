#!/bin/bash
if [ -z $1 ]; then
	echo "missing param"
	exit;
fi


 ssh-keygen -f "/root/.ssh/known_hosts" -R $1
echo "Cloning..."
rsync -zaHl   --exclude=/etc/hostname --exclude=/etc/udev/rules.d/70-persistent-net.rules --exclude=/dev/*  --exclude=/proc/* --exclude=/tmp/* --exclude=/lost+found/* / $1:/
echo "Done Cloning"
 ssh-keygen -f "/root/.ssh/known_hosts" -R $1











exit
echo "Setting up ssh"
ssh $1 cp /root/rsync/clonessh_config /etc/ssh/sshd_config
echo $2 > /root/rsync/hostname
 ssh-keygen -f "/root/.ssh/known_hosts" -R $1

ssh $1 cp /root/rsync/hostname /etc/hostname
rm /root/rsync/hostname
echo "Done setting ssh"

echo "Rebooting"

ssh $1 reboot



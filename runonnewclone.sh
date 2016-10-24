#!/bin/bash


if [ -z $1 ]; then
        echo "missing param"
        exit;
fi

/root/rsync/restore_ownership.pl < /root/rsync/owner.txt

echo "Setting up ssh"
cp /root/rsync/clonessh_config /etc/ssh/sshd_config
echo $1 > /etc/hostname
echo "Done setting ssh"

chmod u+s /usr/bin/sudo

echo "Rebooting"
reboot

#!/bin/bash
date > /root/now.txt

find / -exec ls -land {} \; > /root/rsync/owner.txt
rsync -zaHl  --exclude=/var/www/magento*/session  --exclude=/etc/hostname --exclude=/etc/udev/rules.d/70-persistent-net.rules --exclude=/dev/* --exclude=/sys/* --exclude=/proc/* --exclude=/tmp/* --exclude=/lost+found/* --exclude=/root/swapfile* --exclude=/var/log/* --delete / 11895@ch-s011.rsync.net:prime

exit;
rsync -avz /var --delete 11895@ch-s011.rsync.net:prime
rsync -avz /usr --delete 11895@ch-s011.rsync.net:prime
rsync -avz /etc --delete 11895@ch-s011.rsync.net:prime
rsync -avz /home --delete 11895@ch-s011.rsync.net:prime
rsync -avz /sbin --delete 11895@ch-s011.rsync.net:prime
rsync -avz /bin --delete 11895@ch-s011.rsync.net:prime
rsync -avz /lib --delete 11895@ch-s011.rsync.net:prime
rsync -avz /srv --delete 11895@ch-s011.rsync.net:prime
#rsync -avz /dev --delete 11895@ch-s011.rsync.net:prime








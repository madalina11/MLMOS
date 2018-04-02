#!/bin/bash
{
yum -y update
sudo ip addr add 192.168.50.5 dev enp0s3

sudo sed -n 'H;${x;s/\#PasswordAuthentication yes/PasswordAuthentication no/;p;}
' /etc/ssh/sshd_config > tmp_sshd_config

sudo cat tmp_sshd_config >/etc/ssh/sshd_config
sudo rm tmp_sshd_config
sudo ssh-keygen -t rsa

sudo sed 's/SELINUX=/#SELINUX=' /etc/selinux/config >tmp_config
sudo cat tmp_config > /etc/selinux/config
sudo rm tmp_config

sudo setenforce 0

} &> /var/log/system-bootstrap.log

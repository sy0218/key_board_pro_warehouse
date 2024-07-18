#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_first  Start...."
echo "[`date`] Time_Stamp : net-tools 설치  Start...."
# apt update 및 net-tools 설치
apt update -y
apt install net-tools -y
echo "[`date`] Time_Stamp : net-tools 설치  End...."; echo "";


echo "[`date`] Time_Stamp : NIC name 변경  Start...."
# NIC NAME 변경
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 biosdevname=0"/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo "[`date`] Time_Stamp : NIC name 변경  End...."; echo "";


# pipline 파일에 실행완료 체크
sed -i 's/1:0/1:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_first  End...."

# 리부트
reboot

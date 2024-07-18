#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_four  Start...."


echo "[`date`] Time_Stamp : 방화벽 비활성화  Start...."
# 방화벽 비활성화
systemctl disable --now ufw
echo "[`date`] Time_Stamp : 방화벽 비활성화  End...."; echo "";


echo "[`date`] Time_Stamp : Swap 파일 비활성화, /etc/fstab 수정  Start...."
# Swap 파일 비활성화 및 /etc/fstab 수정
swapoff /swap.img
# data가 저장될 영역 filesystem check 부분 0 0으로 수정(현재는 boot)
sed -i 's/\/boot ext4 defaults 0 1/\/boot ext4 defaults 0 0/g' /etc/fstab
# /swap.img 라인 삭제
sed -i '/^\/swap\.img/d' /etc/fstab
echo "[`date`] Time_Stamp : Swap 파일 비활성화, /etc/fstab 수정  End...."; echo "";


echo "[`date`] Time_Stamp : Locale 설정  Start...."
# locale 설정(한국어 로케일 생성하고 UTF-8 인코딩 사용하여 설정)
# 시스템이 한국어 텍스트를 올바르게 처리가능!!!
apt update && apt install language-pack-ko -y
locale-gen ko_KR.UTF-8
echo "[`date`] Time_Stamp : Locale 설정  End...."; echo "";


echo "[`date`] Time_Stamp : Time zone, Ntp 설정  Start...."
# Time zone 설정
timedatectl set-timezone Asia/Seoul
sed -i 's/^#NTP=/NTP=0.kr.pool.ntp.org/g' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd
echo "[`date`] Time_Stamp : Time zone, Ntp 설정  End...."


echo "[`date`] Time_Stamp : SSH 설정  Start...."
# SSH 설정, ssh 통해 루트 계정 로그인 허용
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/newday.conf
systemctl reload sshd
echo "[`date`] Time_Stamp : SSH 설정  End...."; echo "";


echo "[`date`] Time_Stamp : open files 설정  Start...."
# open files 설정, root 사용자가 열수있는 파일 수 증가
echo "root - nofile 65536" > /etc/security/limits.d/newday.conf
echo "[`date`] Time_Stamp : open files 설정  End...."; echo "";


# pipline 파일에 실행완료 체크
sed -i 's/4:0/4:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_four  End...."

# 리부트
reboot

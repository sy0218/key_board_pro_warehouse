#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_second  Start...."
echo "[`date`] Time_Stamp : 네트워크 추가설정(/etc/netplan/00-installer-config.yaml)  Start...."

# 정적할당( 지금은 dhcp이기때문에 따로 설정파일 할 필요 없음)
# NIC NAME 변경
#sed -i 's/gateway4.*//g' /etc/netplan/00-installer-config.yaml
# 네트워크 수정 적용
#netplan apply
echo "[`date`] Time_Stamp : 네트워크 추가설정(/etc/netplan/00-installer-config.yaml)  End...."; echo "";

# pipline 파일에 실행완료 체크
sed -i 's/2:0/2:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_second  End...."
#리부트
reboot

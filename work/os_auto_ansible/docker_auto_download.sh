#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_seven  Start...."
echo "[`date`] Time_Stamp : docker auto download Start...."


echo "[`date`] Time_Stamp : 패키지 업데이트 및 필요 패키지 설치 Start...."
apt update
apt install apt-transport-https ca-certificates curl software-properties-common -y
echo "[`date`] Time_Stamp : 패키지 업데이트 및 필요 패키지 설치 End...."; echo "";


echo "[`date`] Time_Stamp : 도커 GPG 키 추가 및 도커 공식 apt 저장소 추가 Start...."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository --yes "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "[`date`] Time_Stamp : 도커 GPG 키 추가 및 도커 공식 apt 저장소 추가 End...."; echo "";


echo "[`date`] Time_Stamp : 시스템 패키지 업데이트 및 도커 설치, 도커 사용자 권한 설정  Start...."
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
usermod -aG docker $USER
echo "[`date`] Time_Stamp : 시스템 패키지 업데이트 및 도커 설치, 도커 사용자 권환 설정  End...."; echo "";

echo "[`date`] Time_Stamp : docker auto download End...."

# pipline 파일에 실행완료 체크
sed -i 's/7:0/7:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_seven  Start...."

reboot

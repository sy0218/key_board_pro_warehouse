#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_three  Start...."

echo "[`date`] Time_Stamp : Cloud-init 비활성화  Start...."
# cloud-init 비활성화( 인스턴스 초기 구성 및 설정을 수동으로 관리하가 위함)
# cloud-init 비활성화를 위한 디렉토리가 존재하지 않을시 생성
if [ ! -d "/etc/cloud" ]; then
        echo "/etc/cloud 디렉토리 생성"
        # -p 옵션은 중간 디렉토리를 자동으로 생성
        mkdir -p "/etc/cloud"
fi

# cloud-init 비활성화를 위한 파일 생성
touch /etc/cloud/cloud-init.disabled
echo "[`date`] Time_Stamp : Cloud-init 비활성화  End...."; echo"";

# pipline 파일에 실행완료 체크
sed -i 's/3:0/3:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_three  End...."

# 리부트
reboot

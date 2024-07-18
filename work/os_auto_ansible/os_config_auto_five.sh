#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_five  Start...."

echo "[`date`] Time_Stamp : logrotate 설정  Start...."
# logrotate 설정(로그파일 관리 설정 변경)
# ^# rotate log files weekly$ 해당 부분 찾으면 !b(다음으로 넘어감); > n(다음줄로); > c\[치환할 문자](해 당줄 변경)
sed -i '/^# rotate log files weekly$/!b;n;c\monthly' /etc/logrotate.conf
sed -i '/^# of \/var\/log\/syslog\.$/!b;n;c\su root adm' /etc/logrotate.conf
sed -i '/^# keep 4 weeks worth of backlogs$/!b;n;c\rotate 12' /etc/logrotate.conf
sed -i '/^# create new \(empty\) log files after rotating old ones$/!b;n;c\create' /etc/logrotate.conf
sed -i '/^# packages drop log rotation information into this directory$/!b;n;c\include \/etc\/logrotate.d' /etc/logrotate.conf
echo "[`date`] Time_Stamp : logrotate 설정  End...."; echo "";


echo "[`date`] Time_Stamp : 시스템 기본 shell 변경  Start...."
# 시스템 기본 shell변경
# dash 패키지 설정을 false로 설정
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
echo "[`date`] Time_Stamp : 시스템 기본 shell 변경  End...."; echo "";


echo "[`date`] Time_Stamp : 패키지 설치(java), 업데이트  Start...."
## 외부 네트워크 접속 제한시 deb패키지를 서버에 업로드한후 설치
## dpkg -i *.deb
# 패키지 설치 및 업데이트
# java패키지 설치
apt update && apt install --allow-downgrades --allow-change-held-packages -y net-tools openjdk-8-jdk=8u312-b07-0ubuntu1 openjdk-8-jdk-headless=8u312-b07-0ubuntu1 openjdk-8-jre=8u312-b07-0ubuntu1 openjdk-8-jre-headless=8u312-b07-0ubuntu1
# 패키지 업데이트, autoremove(사용되지 않는 패키지나 의존성이 해결된 패키지 제거)
apt update
export DEBIAN_FRONTEND=noninteractive
apt upgrade -y
apt autoremove -y
echo "[`date`] Time_Stamp : 패키지 설치(java), 업데이트  End...."; echo "";


# pipline 파일에 실행완료 체크
sed -i 's/5:0/5:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_five  End...."

# 리부트
reboot

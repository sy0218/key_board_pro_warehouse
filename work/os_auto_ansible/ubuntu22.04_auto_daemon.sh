#!/usr/bin/bash

DIR_PATH='/data/work/os_auto_ansible'

# 서버 활성화시 특정 스크립트 실행하는 데몬 서비스 파일
cat << EOF > /etc/systemd/system/config_auto_pipline.service
## 서비스 간단 설명 ##
[Unit]
Description=ubuntu22.04_config Auto pipeline script execution

## 서비스 섹션 ##
[Service]
# 서비스 유형 >>> 단순 프로세스
Type=simple
# 서비스 실행시 실행할 명령 지정
ExecStart=/bin/bash -c 'if [ ! -f "${DIR_PATH}/ubuntu22.04_os_auto_pipline.log" ]; then touch "${DIR_PATH}/ubuntu22.04_os_auto_pipline.log"; fi; ${DIR_PATH}/ubuntu22.04_os_auto_pipline.sh >> ${DIR_PATH}/ubuntu22.04_os_auto_pipline.log 2>&1'
## 서비스가 어느시점에 시작되어야 하는지 ##
[Install]
# 다중 사용자 모드 진입시 서비스 시작
WantedBy=multi-user.target
EOF
#systemd에 서비스 등록
systemctl enable config_auto_pipline.service
#systemd에 서비스 시작
systemctl start config_auto_pipline.service

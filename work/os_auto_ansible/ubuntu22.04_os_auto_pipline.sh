#!/usr/bin/bash

# export 쉘 하위로 전역변수 설정
export DIR_PATH='/data/work/os_auto_ansible'

# 각 프로세스는 pipline_check.txt 공유자원 사용
for pipline_values in `cat ${DIR_PATH}/pipline_check.txt`
do
        pipline_num=$(echo $pipline_values | awk -F ':' '{print $1}')
        pipline_check=$(echo $pipline_values | awk -F ':' '{print $2}')
        echo $pipline_num $pipline_check

        if [ $pipline_check -eq 0 ]; then
                if [ $pipline_num -eq 1 ]; then
                        ${DIR_PATH}/os_config_auto_first.sh
                elif [ $pipline_num -eq 2 ]; then
                        ${DIR_PATH}/os_config_auto_second.sh
                elif [ $pipline_num -eq 3 ]; then
                        ${DIR_PATH}/os_config_auto_three.sh
                elif [ $pipline_num -eq 4 ]; then
                        ${DIR_PATH}/os_config_auto_four.sh
                elif [ $pipline_num -eq 5 ]; then
                        ${DIR_PATH}/os_config_auto_five.sh
                elif [ $pipline_num -eq 6 ]; then
                        ${DIR_PATH}/os_config_auto_six.sh
                elif [ $pipline_num -eq 7 ]; then
                        ${DIR_PATH}/docker_auto_download.sh
                fi
        fi
done

# 서비스 멈춤
systemctl stop config_auto_pipline.service
# 서비스 비활성화
systemctl disable config_auto_pipline.service

#!/usr/bin/bash

echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_six  Start...."


echo "[`date`] Time_Stamp : 패키지 버전 고정, 자동 업데이트 비활성화  Start...."
# kernel 및 openjdk 패키지 버전 고정!!
apt-mark hold $(uname -r) openjdk-8-jdk openjdk-8-jdk-headless openjdk-8-jre openjdk-8-jre-headless

# 패키지 자동 업데이트 비활성화
sed -i 's/APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/' /etc/apt/apt.conf.d/20auto-upgrades
sed -i 's/APT::Periodic::Unattended-Upgrade "1";/APT::Periodic::Unattended-Upgrade "0";/' /etc/apt/apt.conf.d/20auto-upgrades

# 패키지 설치 후 서비스 재시작 UI 비활성화
sed -i 's/^#$nrconf{restart}.*/$nrconf{restart} = '\''l'\'';/g' /etc/needrestart/needrestart.conf
echo "[`date`] Time_Stamp : 패키지 버전 고정, 자동 업데이트 비활성화  End...."; echo "";



echo "[`date`] Time_Stamp : 시스템 공통 환경 설정  Start...."
# 환경 변수 및 alias 설정
# /root/.bashrc
if ! grep -qE '^source /etc/senius.conf$|^alias rm='\''.*rm -i'\''$|^alias cp='\''.*cp -i'\''$|^alias mv='\''.*mv -i'\''' /root/.bashrc; then
    sed -i '/^# for examples$/!b;a\
source /etc/senius.conf\
alias rm='\''rm -i'\''\
alias cp='\''cp -i'\''\
alias mv='\''mv -i'\''' /root/.bashrc
fi


if ! grep -Fxq "PS1='[\h:\$PWD] '" /root/.bashrc; then
    echo "PS1='[\h:\$PWD] '" >> /root/.bashrc
fi



for user_dir in $(ls -d /home/*/)
do
# /home/{USER}/.bashrc
        if ! grep -qE '^source /etc/senius.conf$|^alias rm='\''.*rm -i'\''$|^alias cp='\''.*cp -i'\''$|^alias mv='\''.*mv -i'\''' ${user_dir}.bashrc; then
        sed -i '/^# for examples$/!b;a\
        source /etc/senius.conf\
        alias rm='\''rm -i'\''\
        alias cp='\''cp -i'\''\
        alias mv='\''mv -i'\''' ${user_dir}.bashrc
        fi

        if ! grep -Fxq "PS1='[\h:\$PWD] '" ${user_dir}.bashrc; then
        echo "PS1='[\h:\$PWD] '" >> ${user_dir}.bashrc
        fi
done
# /etc/skel/.bashrc
if ! grep -qE '^source /etc/senius.conf$|^alias rm='\''.*rm -i'\''$|^alias cp='\''.*cp -i'\''$|^alias mv='\''.*mv -i'\''' /etc/skel/.bashrc; then
    sed -i '/^# for examples$/!b;a\
source /etc/senius.conf\
alias rm='\''rm -i'\''\
alias cp='\''cp -i'\''\
alias mv='\''mv -i'\''' /etc/skel/.bashrc
fi

if ! grep -Fxq "PS1='[\h:\$PWD] '" /etc/skel/.bashrc; then
    echo "PS1='[\h:\$PWD] '" >> /etc/skel/.bashrc
fi

# /etc/senius.conf(시스템 전역 변수)
cat << EOF > /etc/senius.conf
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/data/sy0218/hadoop-3.3.5
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export HADOOP_YARN_HOME=\$HADOOP_HOME
export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop
export HADOOP_LOG_DIR=/logs/hadoop
export HADOOP_PID_DIR=/var/run/hadoop/hdfs
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=\$HADOOP_COMMON_LIB_NATIVE_DIR"
export HIVE_HOME=/data/sy0218/apache-hive-3.1.3-bin
export HIVE_AUX_JARS_PATH=\$HIVE_HOME/aux
export PATH=\$JAVA_HOME/bin:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin:\$HIVE_HOME/bin:\$HIVE_AUX_JARS_PATH/bin:\$PATH
EOF
echo "[`date`] Time_Stamp : 시스템 공통 환경 설정  End...."; echo "";


# pipline 파일에 실행완료 체크
sed -i 's/6:0/6:1/' ${DIR_PATH}/pipline_check.txt
echo "[`date`] Time_Stamp : ubuntu22.04 auto config pipline_six  End...."

# 리부트
reboot

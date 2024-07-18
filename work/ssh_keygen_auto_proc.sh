#!/usr/bin/bash

echo "[`date`] Time_Stamp : ssh-keygen auto Start...."

echo "[`date`] Time_Stamp : ansible 설치 Start...."
/data/work/ssh_keygen_auto_zero.sh
echo "[`date`] Time_Stamp : ansible 설치 End...."; echo "";


echo "[`date`] Time_Stamp : ssh-keygen 배포  Start...."
/data/work/ssh_keygen_auto_first.sh
echo "[`date`] Time_Stamp : ssh-keygen 배포  End...."; echo "";


echo "[`date`] Time_Stamp : /etc/hosts 만들기  Start...."
/data/work/hosts_set_auto.sh
echo "[`date`] Time_Stamp : /etc/hosts 만들기  End...."; echo "";


echo "[`date`] Time_Stamp : ssh-keygen scp_rsa_id  Start...."
/data/work/ssh_keygen_auto_second.sh
echo "[`date`] Time_Stamp : ssh-keygen scp_rsa_id  End...."; echo "";


echo "[`date`] Time_Stamp : authorized_keys 만들기  Start...."
/data/work/ssh_keygen_auto_three.sh
echo "[`date`] Time_Stamp : authorized_keys 만들기  End...."; echo "";


echo "[`date`] Time_Stamp : authorized_keys 모든서버 배포  Start...."
/data/work/ssh_keygen_auto_four.sh
echo "[`date`] Time_Stamp : authorized_keys 모든서버 배포  End...."; echo "";

echo "[`date`] Time_Stamp : ssh-keygen auto End...."

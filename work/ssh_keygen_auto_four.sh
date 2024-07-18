#!/usr/bin/bash

ip_file="/data/work/system_download.txt"

ssh_home="/root/.ssh"

ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

source_ip=${ip_array[-1]}
echo $source_ip

for ((i=${len_array}-2; i>=0; i--));
do
        dest_ip=${ip_array[$i]}
        echo $dest_ip
        sudo /usr/bin/expect << EOD
        spawn scp root@${source_ip}:${ssh_home}/authorized_keys root@${dest_ip}:${ssh_home}/authorized_keys
        expect {
        "*yes/no*" {
                send "yes\r"
                exp_continue
        }
        "*assword:" {
                send "nds1101\r"
                exp_continue
        }
        "*Overwrite*" {
                send "y\r"
                exp_continue
        }
        eof
}
EOD
        sleep 2
done

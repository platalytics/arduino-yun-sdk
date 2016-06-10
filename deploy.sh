#!/bin/bash

if [ $# -ne 7 ]; then
    echo "usage: ./deploy.sh <board-ip> <board-username> <board-password> <ssh-port> <device-key> <host> <api-key>"
else
    board_ip=$1
    board_username=$2
    board_password=$3
    ssh_port=$4
    device_id=$5
    host=$6
    api_key=$7

    # defining paths
    libraries="./lib"
    code_path="./src"
    core_path="./core"

    chmod 755 ./copy.sh
    chmod 755 ./setup.sh

    echo "starting..."
    curl -H 'Content-Type: application/json' -X POST -d '{"device_key":"'${device_id}'","status":"true","step":"1"}' http://${host}/iot/api/devices/deploy?api_key=${api_key}

    # monitoring script deployment
    ./copy.sh ${board_ip} ${board_username} ${board_password} ${ssh_port} ${core_path} /root/ 1>/dev/null

    # copying code_path files
    ./copy.sh ${board_ip} ${board_username} ${board_password} ${ssh_port} ${code_path} /root/ 1>/dev/null

    # copying library files
    ./copy.sh ${board_ip} ${board_username} ${board_password} ${ssh_port} ${libraries} /root/ 1>/dev/null


    curl -H 'Content-Type: application/json' -X POST -d '{"device_key":"'${device_id}'","status":"true","step":"2"}' http://${host}/iot/api/devices/deploy?api_key=${api_key}

    # setup
    ./setup.sh ${board_ip} ${board_username} ${board_password} ${device_id} ${host} ${api_key} ${ssh_port}
fi

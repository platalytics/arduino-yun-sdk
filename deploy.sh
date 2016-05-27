#!/bin/bash

if [ $# -ne 6 ]; then
    echo "usage: ./deploy.sh <board-ip> <board-username> <board-password> <device-key> <host> <api-key>"
else
	board_ip=$1
	board_username=$2
	board_password=$3
	device_id=$4
    host=$5
    api_key=$6

	libraries="./lib"
	code_path="./src"
	core_path="./core_path"

	chmod 755 ./copy.sh
	chmod 755 ./setup.sh

	# monitoring script deployment
	./copy.sh $board_ip $board_username $board_password $core_path /root/ 1>/dev/null

	# copying code_path files
	./copy.sh ${board_ip} ${board_username} ${board_password} ${code_path} /root/ 1>/dev/null

	# copying library files
	./copy.sh ${board_ip} ${board_username} ${board_password} ${libraries} /root/ 1>/dev/null

	# setup
    ./setup.sh ${board_ip} ${board_username} ${board_password} ${device_id} ${host} ${api_key}
fi

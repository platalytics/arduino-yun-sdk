#!/bin/bash

if [ $# -ne 5 ]; then
    echo "usage: ./deploy.sh <board-ip> <board-username> <board-password> <device-group-id> <device-id>"
else
	boardIp=$1
	boardUserName=$2
	boardPassword=$3
	deviceGroupId=$4
	deviceId=$5

	libraryPath="./lib"
	codePath="./src"
	monitoringDaemonPath="./monitoring"

	chmod 755 ./copy.sh
	chmod 755 ./setup.sh

	# monitoring script deployment
	./copy.sh $boardIp $boardUserName $boardPassword $monitoringDaemonPath /root/ 1>/dev/null

	# copying code files
	./copy.sh $boardIp $boardUserName $boardPassword $codePath /root/ 1>/dev/null

	# copying library files
	./copy.sh $boardIp $boardUserName $boardPassword $libraryPath /root/ 1>/dev/null

	# setup
	./setup.sh $boardIp $boardUserName $boardPassword $deviceId

	curl -H "Content-Type: application/json" -X POST -d '{"device_key":"'$deviceId'","status":"true"}' http://54.89.145.136:5000/iot/api/devices/deployFinish?api_key=35454545
fi

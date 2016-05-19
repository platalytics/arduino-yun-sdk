#!/bin/bash

if [ $# -ne 7 ]; then
    echo "usage: ./deploy.sh <board-ip> <board-username> <board-password> <device-key> <host> <api-key>"
else
	boardIp=$1
	boardUserName=$2
	boardPassword=$3
	deviceId=$4
    host=$5
    apiKey=$6

	libraryPath="./lib"
	codePath="./src"
	monitoringDaemonPath="./logger"

	chmod 755 ./copy.sh
	chmod 755 ./setup.sh

	# monitoring script deployment
	./copy.sh $boardIp $boardUserName $boardPassword $monitoringDaemonPath /root/ 1>/dev/null

	# copying code files
	./copy.sh $boardIp $boardUserName $boardPassword $codePath /root/ 1>/dev/null

	# copying library files
	./copy.sh $boardIp $boardUserName $boardPassword $libraryPath /root/ 1>/dev/null

	# setup
	./setup.sh $boardIp $boardUserName $boardPassword $deviceId $host $apiKey
fi

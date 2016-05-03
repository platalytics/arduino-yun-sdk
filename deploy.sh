#!/bin/bash

boardIp=$1
boardUserName=$2
boardPassword=$3
hubId=$4
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

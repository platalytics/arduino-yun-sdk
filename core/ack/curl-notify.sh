#!/bin/bash

# validate arguments

if [ $# -ne 3 ]; then
    echo "usage: ./curl-notify.sh <device_id> <front_end_host> <step>"
else
    device_id=$1
    front_end_host=$2
    step=$3

    curl -H 'Content-Type: application/json' -X POST -d '{"device_key":"'${device_id}'","status":"true","step":"'${step}'"}' ${front_end_host}

fi

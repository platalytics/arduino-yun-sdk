#!/usr/bin/expect

# validate arguments

set timeout -1
set board_ip [lindex $argv 0]
set board_username [lindex $argv 1]
set board_password [lindex $argv 2]
set device_id [lindex $argv 3]
set host [lindex $argv 4]
set api_key [lindex $argv 5]

set remote_end "$board_username@$board_ip"

send_user "\nmake sure your yun board is connected to internet to install these dependencies"
send_user "\n- distribute\n- python-openssl\n- pip\n- paho-mqtt-1.1\n- kafka-python-1.1.1\n"

spawn ssh $remote_end
expect {
    -re ".*yes/no.*" {
        send "yes\r"; exp_continue
	-re ".*assword.*" { send "$board_password\r" }
    }
    -re ".*assword.*" { send "$board_password\r" }
}

expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"3\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }

# pre-installation setup
expect "*~#" { send "opkg update\r" }
expect "*~#" { send "opkg install distribute\r" }
expect "*~#" { send "opkg install python-openssl\r" }
expect "*~#" { send "opkg install coreutils-nohup\r" }
expect "*~#" { send "easy_install pip\r" }

# installing local/offline versions of supported python libraries 
expect "*~#" { send "pip install /root/lib/paho-mqtt-1.1.tar.gz\r" }
expect "*~#" { send "pip install /root/lib/kafka-python-1.1.1.tar.gz\r" }

# other protocol packages
# expect "*~#" { send "pip install /root/lib/amqp-1.4.7.tar.gz\r" }
# expect "*~#" { send "pip install /root/lib/CoAPthon-4.0.0.tar.gz -r /root/lib/coap_req\r" }

# setting permissions
expect "*~#" { send "chmod 775 /root/core/logger/loggerdaemon.py\r" }
expect "*~#" { send "chmod 775 /root/core/controls/controlsdaemon.py\r" }
expect "*~#" { send "chmod 775 /root/src/mqtt/mqtt-sender.py\r" }

# setting running daemons

expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"4\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }
expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"5\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }

expect "*~#" { send "echo ${device_id} 1>/var/key.conf\r" }
expect "*~#" { send "nohup sh -c '/root/core/logger/loggerdaemon.py' 1>/dev/null 2>&1 &\r" }
expect "*~#" { send "echo ${device_id}controlcallback 1>/var/controls.conf\r" }
expect "*~#" { send "nohup sh -c '/root/core/controls/controlsdaemon.py' 1>/dev/null 2>&1 &\r" }

expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"6\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }
expect "*~#" { send "rm -rf /root/lib\r" }

expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"7\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }
expect "*~#" { send "curl -H \"Content-Type: application/json\" -X POST -d '{\"device_key\":\"'${device_id}'\",\"status\":\"true\",\"step\":\"8\"}' \"http://${host}/iot/api/devices/deploy?api_key=${api_key}\"\r" }

expect "*~#" { send "exit\r" }

interact

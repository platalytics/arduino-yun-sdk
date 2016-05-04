#!/usr/bin/expect

# validate arguments

set timeout -1
set boardIp [lindex $argv 0]
set boardUserName [lindex $argv 1]
set boardPassword [lindex $argv 2]
set deviceId [lindex $argv 3]

set remoteEnd "$boardUserName@$boardIp"

send_user "\nmake sure your yun board is connected to internet to install these dependencies"
send_user "\n- distribute\n- python-openssl\n- pip\n- paho-mqtt-1.1\n- kafka-python-1.1.1\n"

spawn ssh $remoteEnd
expect {
    -re ".*yes/no.*" {
        send "yes\r"; exp_continue
	-re ".*assword.*" { send "$boardPassword\r" }
    }
    -re ".*assword.*" { send "$boardPassword\r" }
}

# pre-installation setup
expect "*~#" { send "opkg update\r" }
expect "*~#" { send "opkg install distribute\r" }
expect "*~#" { send "opkg install python-openssl\r" }
expect "*~#" { send "opkg install coreutils-nohup\r" }
expect "*~#" { send "easy_install pip\r" }

# installing local/offline versions of supported python libraries 
expect "*~#" { send "pip install /root/lib/paho-mqtt-1.1.tar.gz\r" }
expect "*~#" { send "pip install /root/lib/kafka-python-1.1.1.tar.gz\r" }

##<<OTHER_PACKAGES
##    expect "*~#" { send "pip install /root/lib/amqp-1.4.7.tar.gz\r" }
##    expect "*~#" { send "pip install /root/lib/CoAPthon-4.0.0.tar.gz -r /root/lib/coap_req\r" }
##OTHER_PACKAGES

expect "*~#" { send "chmod 775 /root/monitoring/log_monitoring.py\r" }
expect "*~#" { send "chmod 775 /root/src/mqtt/mqtt-sender.py\r" }
expect "*~#" { send "nohup sh -c '/root/monitoring/log_monitoring.py $deviceId &'\r" }

expect "*~#" { send "exit\r" }

interact
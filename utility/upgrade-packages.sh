#!/usr/bin/expect

# validate arguments
if {$argc!= 3} {
    send_user "usage: ./upgrade-packages.sh <board-ip> <board-username> <board-password>\n"
    exit
}

set timeout -1
set boardIp [lindex $argv 0]
set boardUserName [lindex $argv 1]
set boardPassword [lindex $argv 2]
set remoteEnd "$boardUserName@$boardIp"

send_user "\nupgrading packages...\n"

spawn ssh $remoteEnd
expect {
    -re ".*yes/no.*" {
        send "yes\r"; exp_continue
    -re ".*assword.*" { send "$boardPassword\r" }
    }
    -re ".*assword.*" { send "$boardPassword\r" }
}

# upgrading pip package
expect "*~#" { send "pip install --upgrade pip\r" }
expect "*~#" { send "exit\r" }

interact
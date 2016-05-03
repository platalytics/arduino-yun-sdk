#!/usr/bin/expect

# validate arguments

set timeout 10
set boardIp [lindex $argv 0]
set boardUserName [lindex $argv 1]
set boardPassword [lindex $argv 2]
set target [lindex $argv 3]
set destination [lindex $argv 4]
set remoteEnd "$boardUserName@$boardIp:$destination"

send_user "\ntransmitting $target to remote directory: $remoteEnd...\n"

# scp automatically creates the missing directory
spawn scp -r $target $remoteEnd
expect {
    # In case this is the first time
    -re ".*yes/no.*" {
        send "yes\r"; exp_continue
	-re ".*assword.*" { send  "$boardPassword\r" }
    }
    -re ".*assword.*" { send "$boardPassword\r" }
}

expect {
    eof {
	   send_user "Completed!\n"
    }
}
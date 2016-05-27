#!/usr/bin/expect

# validate arguments

set timeout 10
set board_ip [lindex $argv 0]
set board_username [lindex $argv 1]
set board_password [lindex $argv 2]
set target [lindex $argv 3]
set destination [lindex $argv 4]
set remote_end "$board_username@$board_ip:$destination"

send_user "\ntransmitting $target to remote directory: $remote_end...\n"

# scp automatically creates the missing directory
spawn scp -r $target $remote_end
expect {
    # In case this is the first time
    -re ".*yes/no.*" {
        send "yes\r"; exp_continue
	-re ".*assword.*" { send  "$board_password\r" }
    }
    -re ".*assword.*" { send "$board_password\r" }
}

expect {
    eof {
	   send_user "copied successfully\n"
    }
}
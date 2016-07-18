#!/usr/bin/env bats

@test "check source directory" {
    run stat ../src
    [ $status = 0 ]
}

@test "check source/main directory" {
    run stat ../src/main
    [ $status = 0 ]
}

@test "check source/main/amqp directory" {
    run stat ../src/main/amqp
    [ $status = 0 ]
}

@test "check source/main/coap directory" {
    run stat ../src/main/coap
    [ $status = 0 ]
}

@test "check source/main/mqtt directory" {
    run stat ../src/main/mqtt
    [ $status = 0 ]
}

@test "check source/main/stomp directory" {
    run stat ../src/main/stomp
    [ $status = 0 ]
}

@test "check library directory" {
    run stat ../lib
    [ $status = 0 ]
}

@test "check core directory" {
    run stat ../core
    [ $status = 0 ]
}

@test "check core/bootloader directory" {
    run stat ../core/bootloader
    [ $status = 0 ]
}

@test "check core/controls directory" {
    run stat ../core/controls
    [ $status = 0 ]
}

@test "check core/logger directory" {
    run stat ../core/logger
    [ $status = 0 ]
}

@test "check core/logger/collector directory" {
    run stat ../core/logger/collector
    [ $status = 0 ]
}
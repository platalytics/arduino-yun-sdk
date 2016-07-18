#!/usr/bin/env bats

@test "expect utility found" {
    command -v expect
}

@test "ssh installed" {
    command -v ssh
}
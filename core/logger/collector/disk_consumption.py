#!/usr/bin/env python

import os
disk = os.statvfs("/")


def get_total_disk_space():
    global disk
    return (float(disk.f_bsize * disk.f_blocks)) / 1024

def get_total_used_space():
    global disk
    return (float(disk.f_bsize * (disk.f_blocks - disk.f_bfree))) / 1024

def get_total_avail_space():
    global disk
    return (float(disk.f_bsize * disk.f_bfree)) / 1024
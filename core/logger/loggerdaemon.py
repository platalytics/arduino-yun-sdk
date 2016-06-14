#!/usr/bin/env python

import paho.mqtt.publish as publish
import sys, os, time, json, random


mqtt_broker_ip = '45.55.159.119'
mqtt_broker_port = 1883

# fetching topic name
f = open('/root/key.conf', 'r')
topic_name = f.read()[:-1]
f.close()


while True:
    # fetching memory stats
    f = open('/proc/meminfo', 'r')

    # thanks to https://rosettacode.org/wiki/Linux_CPU_utilization#Python
    last_idle = last_total = 0
    with open('/proc/stat') as file:
        fields = [float(column) for column in file.readline().strip().split()[1:]]
    idle, total = fields[3], sum(fields)
    idle_delta, total_delta = idle - last_idle, total - last_total
    last_idle, last_total = idle, total
    cpu_utilization = 100.0 * (1.0 - idle_delta / total_delta)

    memory_stats_data = {}

    lines = f.read().split("\n")[:-1]
    for i in lines:
        memory_stats_data[i.split(":")[0]] = i.split(":")[1].strip(' ')

    process_count = int(os.popen('ps | wc -l').read())

    # thanks to http://www.roman10.net/2011/07/25/get-disk-space-in-pythonusing-statvfs/
    disk = os.statvfs("/")
    total_disk_space = (float(disk.f_bsize * disk.f_blocks)) / 1024
    total_used_space = (float(disk.f_bsize * (disk.f_blocks - disk.f_bfree))) / 1024
    total_avail_space = (float(disk.f_bsize * disk.f_bfree)) / 1024

    all_stats = [{'MemoryStats': memory_stats_data}, {'CPUStats': {'CPUPercentage': cpu_utilization ,'ThreadCount':0,'ProcessCount':process_count}}, {'DiskStats': {'TotalDiskSpace': total_disk_space,'FreeDiskSpace':total_avail_space,'Used':total_used_space}}]
    json_data = json.dumps(all_stats)

    publish.single(topic_name+'mon', json_data, hostname=mqtt_broker_ip, port=mqtt_broker_port)
    time.sleep(3)

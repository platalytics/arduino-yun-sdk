#!/usr/bin/env python

import paho.mqtt.publish as publish
import sys, os, time, json, random


broker = '45.55.159.119'
port = '1883'

# fetching topic name
f = open('/var/key.conf', 'r')
topic_name = f.read()[:-1]
f.close()


while True:
    # fetching memory stats
    f = open('/proc/meminfo', 'r')

    memory_stats_data = {}

    lines = f.read().split("\n")[:-1]
    for i in lines:
        memory_stats_data[i.split(":")[0]] = i.split(":")[1].strip(' ')

    process_count = int(os.popen('ps | wc -l').read())

    all_stats = [{'MemoryStats': memory_stats_data}, {'CPUStats': {'CPUPercentage': random.uniform(69.5, 81.9)}}, {'DiskStats': {'TotalDiskSpace': '65536','FreeDiskSpace':'24596','Used':'40940'}}]
    json_data = json.dumps(all_stats)
    #parsed = json.loads(json_data)

    print (json_data + "\n")

    publish.single(topic_name+'mon', json_data, hostname=broker, port=port)
    time.sleep(3)

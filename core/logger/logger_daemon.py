#!/usr/bin/env python

import paho.mqtt.publish as publish
import time, json

from collector.memory_collector import get_memory_stats
from collector.cpu_utilization import get_cpu_utilization
from collector.process_count import get_process_count
from collector.disk_consumption import get_total_avail_space, get_total_disk_space, get_total_used_space
from collector.json import construct_json


mqtt_broker_ip = '45.55.159.119'
mqtt_broker_port = 1883

# fetching topic name
key_file = open('/root/key.conf', 'r')
topic_name = key_file.read()[:-1]
key_file.close()


def dump_stats_forever():
    while True:
        cpu_utilization = get_cpu_utilization()
        memory_stats_data = get_memory_stats()
        process_count = get_process_count()

        all_stats = construct_json(memory_stats_data, cpu_utilization, process_count, get_total_disk_space(),
                                   get_total_avail_space(), get_total_used_space())
        json_data = json.dumps(all_stats)

        print json_data

        publish.single(topic_name + 'mon', json_data, hostname=mqtt_broker_ip, port=mqtt_broker_port)
        time.sleep(3)


dump_stats_forever()

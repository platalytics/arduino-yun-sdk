#!/usr/bin/env python

import sys, os, time, json
from kafka import KafkaProducer


kafka_broker = '122.129.79.68:9092'

# fetching topic name
topic_name = sys.argv[1]

# time delay
loop_delay = 5

# configuring producer
producer = KafkaProducer(bootstrap_servers=kafka_broker)

while True:
    # fetching memory stats
    f = open('/proc/meminfo', 'r')

    memory_stats_data = {}

    lines = f.read().split("\n")[:-1]
    for i in lines:
        memory_stats_data[i.split(":")[0]] = i.split(":")[1].strip(' ')

    process_count = int(os.popen('ps | wc -l').read())

    all_stats = [{'MemoryStats': memory_stats_data}, {'ProcessStats': {'ProcessCount': process_count}}]
    json_data = json.dumps(all_stats)
    parsed = json.loads(json_data)

    producer.send(topic_name, json_data)
    time.sleep(loop_delay)

#!/usr/bin/env python


def get_memory_stats():
    file_descriptor = open('/proc/meminfo', 'r')
    memory_stats_data = {}
    lines = file_descriptor.read().split("\n")[:-1]
    for i in lines:
        memory_stats_data[i.split(":")[0]] = i.split(":")[1].strip(' ')

    return memory_stats_data
#!/usr/bin/env python


def get_cpu_utilization():
    last_idle = last_total = 0
    with open('/proc/stat') as file:
        fields = [float(column) for column in file.readline().strip().split()[1:]]
    idle, total = fields[3], sum(fields)
    idle_delta, total_delta = idle - last_idle, total - last_total
    last_idle, last_total = idle, total
    cpu_utilization = 100.0 * (1.0 - idle_delta / total_delta)

    return cpu_utilization

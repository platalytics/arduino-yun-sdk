#!/bin/usr/env


def construct_json(memory_stats_data, cpu_utilization, process_count, total_disk_space, total_avail_space,
                   total_used_space):
    return [{'MemoryStats': memory_stats_data},
            {'CPUStats': {
                'CPUPercentage': cpu_utilization,
                'ThreadCount': 0,  # no threads available in yun
                'ProcessCount': process_count}
            },
            {'DiskStats': {
                'TotalDiskSpace': total_disk_space,
                'FreeDiskSpace': total_avail_space,
                'Used': total_used_space
            }}]

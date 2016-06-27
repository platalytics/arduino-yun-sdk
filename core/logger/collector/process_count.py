#!/usr/bin/env python


def get_process_count():
    from os import popen
    with popen('ps | wc -l') as f:
        return int(f.read())
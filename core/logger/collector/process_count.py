#!/usr/bin/env python

import os


def get_process_count():
    return int(os.popen('ps | wc -l').read())
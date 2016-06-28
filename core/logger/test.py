#!/usr/bin/env python

import unittest, os
from collector.disk_consumption import get_total_used_space, get_total_avail_space, get_total_disk_space
from collector.memory_collector import get_memory_stats
from collector.cpu_utilization import get_cpu_utilization
from collector.process_count import get_process_count
from collector.json import construct_json


class CollectorTest(unittest.TestCase):
    def setUp(self):
        print '\n' + self.id()

    def tearDown(self):
        print self.id() + ' teadDown()'

    '''
    disk stats testing
    '''

    def test_get_total_used_space_if_not_equal_to_zero(self):
        self.assertNotEqual(self, get_total_used_space(), 0)

    def test_get_total_used_space_if_greater_than_equal_zero(self):
        self.assertGreaterEqual(self, get_total_used_space(), 0)

    def test_get_total_avail_space_if_not_equal_to_zero(self):
        self.assertNotEqual(self, get_total_avail_space(), 0)

    def test_get_total_avail_space_if_greater_than_equal_zero(self):
        self.assertGreaterEqual(self, get_total_avail_space(), 0)

    def test_get_total_disk_space_if_not_equal_to_zero(self):
        self.assertNotEqual(self, get_total_disk_space(), 0)

    def test_get_total_disk_space_if_greater_than_equal_zero(self):
        self.assertGreaterEqual(self, get_total_disk_space(), 0)

    def test_if_disk_mounted(self):
        self.assertTrue(self, os.path.exists("/"))

    '''
    memory stats testing
    '''

    def test_memory_if_stats_file_path_exists(self):
        self.assertTrue(self, os.path.exists("/proc/meminfo"))

    def test_get_memory_stats_if_not_available(self):
        self.assertNotEqual(self, get_memory_stats(), "")

    '''
    cpu stats testing
    '''

    def test_cpu_if_stats_file_path_exists(self):
        self.assertTrue(self, os.path.exists("/proc/stat"))

    def test_get_cpu_utilization_if_not_equal_to_zero(self):
        self.assertNotEqual(self, get_cpu_utilization(), 0)

    '''
    process count testing
    '''

    def test_get_process_count_if_not_less_than_zero(self):
        self.assertGreaterEqual(self, get_process_count(), 0)

    '''
    collector json creator testing
    '''

    def test_if_collector_json_creator_is_working(self):
        self.assertNotEqual(self, construct_json(0, 0, 0, 0, 0, 0), "")


if __name__ == "__main__":
    unittest.main()

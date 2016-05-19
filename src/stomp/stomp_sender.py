#!/usr/bin/env python

import time
import sys
import stomp

from optparse import OptionParser


def produce(queue, message):
    conn.send(queue,message)
    conn.disconnect()

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option('-H', '--host', action='store',
                      type='string', dest='host', help='hostname')
    parser.add_option('-p', '--port', action='store',
                      type='int', dest='port', help='port')
    parser.add_option('-U', '--user', action='store',
                      type='string', dest='user', help='username')
    parser.add_option('-P', '--password', action='store',
                      type='string', dest='password', help='password')
    parser.add_option('-q', '--queue', action='store',
                      type='string', dest='queue', help='destination queue')
    parser.add_option('-m', '--message', action='store',
                      type='string', dest='message', help='message to be sent')

    options, args = parser.parse_args()

    if not options.host:
        print("Host name is required!")
        parser.print_help()
        sys.exit(1)
    if not options.port:
        print("Port is required!")
        parser.print_help()
        sys.exit(1)
    if not options.queue:
        print("Queue name is required!")
        parser.print_help()
        sys.exit(1)

    if not options.message:
        print("message is required!")
        parser.print_help()
        sys.exit(1)
    try:
        conn = stomp.Connection([(options.host, options.port)])
        conn.start()
        # optional connect keyword args "username" and "password" like so:
        if options.user:
            conn.connect(username=options.user, password=options.password, wait=True)
        else:
            conn.connect()
    except:
        print("Cannot connect")
        raise

    produce(options.queue, message)
    

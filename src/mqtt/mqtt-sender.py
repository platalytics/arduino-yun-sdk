#!/usr/bin/env python

import sys
import paho.mqtt.publish as publish

"""
MQTT client program parsing command line arguments

@host is hostname where broker is deployed
@topic is topic name on which payload is to be sent
@payload is message to be sent
"""

def main():
    if (len(sys.argv) != 5):
        print("Invalid arguments.")
        print("Pass arguments in correct order as below:")
        print("./mqtt-sender.py <host> <port> <topic> <payload>")
        sys.exit(1)
    
    # retrieving arguments
    host = str(sys.argv[1])
    port = str(sys.argv[2])
    topic = str(sys.argv[3])
    payload = str(sys.argv[4])

    publish.single(topic, payload, hostname = host, port = port)
    
    print("Payload published!")


if __name__ == '__main__':
    main()

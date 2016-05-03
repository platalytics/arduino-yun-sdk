#!/usr/bin/env python

import sys
from coapthon.client.helperclient import HelperClient

"""
CoAP client program parsing command line arguments

@host is hostname where broker is deployed
@port is port number where broker is listening
@resource is the URI path on which this payload is to be sent   
@payload is message to be sent
"""

def main():
    if (len(sys.argv) != 5):
        print("Invalid arguments.")
        print("Pass arguments in correct order as below:")
        print("./coap-sender.py <host> <port> <resource> <payload>")
        sys.exit(1)
    
    # retrieving arguments
    host = str(sys.argv[1])
    port = int(sys.argv[2])
    resource = str(sys.argv[3])
    payload = str(sys.argv[4])
    
    client = HelperClient(server=(host, port))
    response = client.put(resource, payload)
    print response.pretty_print()

    print("Payload published!")

    client.stop()


if __name__ == '__main__':  # pragma: no cover
    main()

#!/usr/bin/env python

import sys
import amqp

"""
AMQP client program parsing command line arguments

@host is hostname where broker is deployed
@exchange is exchange name on which payload is to be sent
@payload is message to be sent
@username and @password are credentials
@defaultExchangeType is exchange type inside RabbitMQ server, on default exchange type is fanout
@defaultSslEnable if SSL secure on not, on default secure connection is disabled
"""

def main():
    if (len(sys.argv) != 6):
        print('Invalid arguments.')
        print('Pass arguments in correct order as below:')
        print('./amqp-sender.py <host> <exchange> <username> <password> <payload>')
        sys.exit(1)

    host = str(sys.argv[1])
    exchange = str(sys.argv[2])
    username = str(sys.argv[3])
    password = str(sys.argv[4])
    payload = str(sys.argv[5])
    defaultExchangeType = 'fanout'
    defaultSslEnable = False

    print("host: " + host)
    print("exchange: " + exchange)
    print("username: " + username)
    print("password: " + password)
    print("payload: " + payload)
    print("defaultExchangeType: " + defaultExchangeType)

    conn = amqp.Connection(host, userid = username, password = password, ssl = defaultSslEnable)
    ch = conn.channel()
    ch.exchange_declare(exchange, defaultExchangeType, auto_delete = False)
    msg = amqp.Message(payload, content_type = 'text/plain', application_headers = {'foo': 7, 'bar': 'baz'})

    # publishing message on iot exchange
    ch.basic_publish(msg, exchange)

    print("Payload published!")

    ch.close()
    conn.close()


if __name__ == '__main__':
    main()

#!/usr/bin/env python

import os
import sys
import paho.mqtt.client as mqtt


def perform_action(action):
    if action == "shutdown":
        os.system("poweroff")
    elif action == "reboot":
        os.system("reboot")
    else:
        print("ERROR: action not registered!")


def on_message(mosq, obj, msg):
    perform_action(str(msg.payload))


client = mqtt.Client()

client.on_message = on_message
client.connect("45.55.159.119", 1883, 60)

f = open('/var/controls.conf', 'r')
client.subscribe(f.read()[:-1], 0)
f.close()

client.loop_forever()

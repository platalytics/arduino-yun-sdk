#!/usr/bin/env python


import os
import sys
import paho.mqtt.client as mqtt


def perform_action(action):
    if action == "shutdown": os.system("poweroff")
    elif action == "reboot": os.system("reboot")
    else: print(1)


def on_message(mosq, obj, msg):
    perform_action(str(msg.payload))


client = mqtt.Client()

client.on_message = on_message
client.connect("45.55.159.119", 1883, 60)

f = open('/var/controldaemon.conf', 'r')
client.subscribe(f.read()[:-1], 0)

client.loop_forever()
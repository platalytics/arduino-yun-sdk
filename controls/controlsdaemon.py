#!/usr/bin/env python


import sys
import paho.mqtt.client as mqtt


def perform_action(action):
    if action == "shutdown": print (-1)
    elif action == "reboot": print(0)
    else: print(1)


def on_message(mosq, obj, msg):
    perform_action(str(msg.payload))


mqttc = mqtt.Client()

mqttc.on_message = on_message
mqttc.connect("45.55.159.119", 1883, 60)

mqttc.subscribe(str(sys.argv[1]) + "controlcallback", 0)

mqttc.loop_forever()
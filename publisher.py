### Microcontroller

import paho.mqtt.client as mqtt
import random
import time

# MQTT Broker Configuration
broker_address = "test.mosquitto.org"
port = 1883
topic = "sensor-data"

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

client = mqtt.Client()
client.on_connect = on_connect
client.connect(broker_address, port, 60)

# data = "<controller_id>:<pin>:<value>|<pin>:<value>|<pin>:<value>"

while True:
    message = ""
    for i in range(1, 10):
        value = round(random.uniform(20, 50), 2)
        message += "1:" + str(i) + ":" + str(value)
        if i < 9:
            message += "|"
    client.publish(topic, message)
    
    time.sleep(5)  # Publish every 5 seconds

### Insert to database

import paho.mqtt.client as mqtt
import psycopg2

# MQTT Broker Configuration
broker_address = "test.mosquitto.org"
port = 1883
topic = "sensor-data"

conn = psycopg2.connect(database="postgres",
                            user="postgres",
                            password="qwerty2631",
                            host="localhost",
                            port="5432")

cursor = conn.cursor()

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    print(f"Received {msg.topic}: {msg.payload.decode()} ")
    sensor_data = msg.payload.decode().split('|')
    for sensor in sensor_data:
        values = sensor.split(':')
        try:
            cursor.execute("SELECT id FROM sensor WHERE microcontrolador_id = %s and pin = %s;",
                (values[0], values[1]))
            result = cursor.fetchall()            
            cursor.execute("INSERT INTO sensor_data (sensor_id, valor) VALUES (%s, %s);",
                (str(result[0][0]), values[2]))
        except (Exception, psycopg2.Error) as error:
            print(error.pgerror)
    conn.commit()

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(broker_address, port, 60)

client.loop_forever()

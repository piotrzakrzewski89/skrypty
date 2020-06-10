#!/usr/bin/python
# Copyright (c) 2014 Adafruit Industries
# Author: Tony DiCola

import sys
import os
import datetime
import mysql.connector
import Adafruit_DHT
import RPi.GPIO as GPIO
from time import *

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(19, GPIO.OUT)
GPIO.setup(21, GPIO.OUT)
GPIO.setup(20, GPIO.OUT)


mydb = mysql.connector.connect(
  host="xxx",
  user="xxx",
  passwd="xxx",
  database="xxx"
)
mycursor = mydb.cursor()

#while True:    
# Parse command line parameters.
   # sensor_args = { '11': Adafruit_DHT.DHT11,
                #'22': Adafruit_DHT.DHT22,
                #'2302': Adafruit_DHT.AM2302 }
    #if len(sys.argv) == 3 and sys.argv[1] in sensor_args:
        #sensor = sensor_args[22]
        #pin = sys.argv[22]
    #else:
        #print('Usage: sudo ./Adafruit_DHT.py [11|22|2302] <GPIO pin number>')
        #print('Example: sudo ./Adafruit_DHT.py 2302 4 - Read from an AM2302 connected to GPIO pin #4')
     #   sys.exit(1)

    #os.system('clear')
    
timenow = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    #print(format(timenow))

tFile = open('/sys/class/thermal/thermal_zone0/temp')
temp = float(tFile.read())
tempC = temp/1000
    #print('cpu={0:0.1f}C'.format(tempC))   
    
GPIO.output(21, GPIO.HIGH)
humidity, temperature = Adafruit_DHT.read_retry(22, 22)
GPIO.output(21, GPIO.LOW)
if humidity > 101:
	GPIO.output(19, GPIO.HIGH)
else:
	GPIO.output(19, GPIO.LOW)

	#if mydb:
  	GPIO.output(20, GPIO.HIGH)
  	#sleep(0.5)
   	#sql = "UPDATE messuring_rooms SET temp='{0:0.1f}' , humidity='{1:0.1f}' WHERE id='1'".format(temperature, humidity)    
   	sql = "INSERT INTO messuring_rooms (temp,humidity,stamp) VALUES ('{0:0.1f}','{1:0.1f}','{2:s}')".format(temperature, humidity,timenow)    

   	mycursor.execute(sql)
   	mydb.commit()   
   	GPIO.output(20, GPIO.LOW)

    #print('Temp={0:0.1f}C  Wilgotnosc={1:0.1f}%'.format(temperature, humidity))
#sleep(0.5)





   


#sleep(598)
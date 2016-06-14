/**
 * Platalytics Inc. (C) 2016
 * Firebrigade demo application for Arduino SDK
*/

#include <Bridge.h>
#include <YunClient.h>
#include <MQTTClient.h>
#include <SoftwareSerial.h>
#include <Adafruit_GPS.h>

#include "platalytics_iot.h"

SoftwareSerial gpsSerial(8, 7);
Adafruit_GPS gps(&gpsSerial);

#define GPSECHO true
#define SECOND_DELAY 1000

#define NO_FIRE_LED_PIN 2
#define FIRE_LED_PIN 3

#define BAUD_RATE 115200
#define GPS_BAUD_RATE 9600

#define SENSOR_MIN 0
#define SENSOR_MAX 1024
#define COMMA_SEPARATOR ","
#define MAC "B4:21:8A:F0:07:56"

YunClient net;
MQTTClient client;
bool again;
uint32_t timer;

void setup() {
  Bridge.begin();
  Serial.begin(BAUD_RATE);
  gps.begin(GPS_BAUD_RATE);
  gps.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCONLY);
  gps.sendCommand(PMTK_SET_NMEA_UPDATE_1HZ);
  gps.sendCommand(PGCMD_ANTENNA);

  Serial.println("REBOOT");

  client.begin(BROKER_IP, net);

  Serial.println("connecting...");
  while (!client.connect("arduino", "try", "try")) Serial.print(".");
  client.subscribe(CALLBACK_TOPIC);

  pinMode(FIRE_LED_PIN, OUTPUT);
  pinMode(NO_FIRE_LED_PIN, OUTPUT);
  gpsSerial.println(PMTK_Q_RELEASE);


  pinMode(4, OUTPUT);

  timer = millis();
  again = true;

  delay(3000);
}

void loop() {
  client.loop();
  char c = gps.read();

  String row;
  char value[10];

  if (gps.newNMEAreceived())
    gps.parse(gps.lastNMEA());


  if (timer > millis()) timer = millis();

  if (millis() - timer > 2000) {
    timer = millis(); // reset the timer

    short range, sensorReading;
    sensorReading = analogRead(A0);
    range = map(sensorReading, SENSOR_MIN, SENSOR_MAX, 0, 3);

    bool fire;
    switch (range) {
      case 0:
      case 1:
        fire = true;
        break;
      case 2:
        fire = false;
        again = true;
        break;
    }

    row.concat(MAC);
    row.concat(COMMA_SEPARATOR);
    row.concat("08/06/2016 ");
    row.concat(gps.hour);
    row.concat(":");
    row.concat(gps.minute);
    row.concat(":");
    row.concat(gps.seconds);
    row.concat(COMMA_SEPARATOR);

    if (gps.fix) {
      dtostrf(gps.latitudeDegrees, 7, 5, (char *)value);
      row.concat(value);
      row.concat(COMMA_SEPARATOR);
      dtostrf(gps.longitudeDegrees, 7, 5, (char *)value);
      row.concat(value);
    }
    else {
      row.concat(NOT_AVAILABLE);
      row.concat(COMMA_SEPARATOR);
      row.concat(NOT_AVAILABLE);
    }

    row.concat(COMMA_SEPARATOR);
    if (fire && again) {
      row.concat("Fire");
      client.publish(PUBLISH_TOPIC, row);
      client.publish(PUBLISH_TOPIC_HELPER, row);
      Serial.println(row);
      again = false;
    }
    else if (!fire) {
      row.concat("NoFire");
      client.publish(PUBLISH_TOPIC, row);
      client.publish(PUBLISH_TOPIC_HELPER, row);
      Serial.println(row);
      again = true;
    }

    row = "";
  }
}

void messageReceived(String topic, String payload, char *bytes, unsigned int length) {
  // data coming in format D[HEX]:[HI/LO]
  
  int pin = -1;
  if (payload[1] >= 'A' && payload[1] <= 'D') pin = int(payload[1] - 55);
  else pin = payload[1] - 48;

  if (pin != -1) {
    if (payload[3] == 'H') {
      digitalWrite(pin, HIGH);
    } else if (payload[3] == 'L') {
      digitalWrite(pin, LOW);
    }
  }
}


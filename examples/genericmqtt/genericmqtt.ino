#include <Bridge.h>
#include <Process.h>

#include "platalytics_config.h"

uint32_t timer;

void setup() {
  Bridge.begin();
  Serial.begin(DEFAULT_SERIAL_BAUD_RATE);
  while (!Serial);

  // initializing timer
  timer = millis();
}

void loop() {
  if (timer > millis()) timer = millis();

  // 5 seconds delay
  if (millis() - timer > S5_DELAY) {
    timer = millis();

    // get readings from the sensors you configured
    // and pass them along in function <publish>

    // see platalytics_config.h
    // enter your hub_id generated by
    // platform application you created
    publish("hub_id", "your_payload_here");
    Serial.println("published!");
  }
}

/**
 * publishes message
 * 
 * @param topic is mqtt topic on which payload will be published
 * @param payload is message/data to be published
 * 
 * @return void
 */
void publish(String topic, String payload) {
  Process p;
  p.begin("python");
  p.addParameter("/root/src/mqtt/mqtt-sender.py");
  p.addParameter(BROKER_IP);
  p.addParameter(BROKER_PORT);
  p.addParameter(topic);
  p.addParameter(payload);
  p.run();  
}

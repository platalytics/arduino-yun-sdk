#include "IoTManager.h"

IoTManager *m;
void setup() {
  m = new IoTManager();
}

void loop() {
  if (!m) return;
  Serial.println(m -> getProtocolName());
  Serial.println(m -> getSensorCount());
  Serial.println(m -> getSensorSchemaLength());
  m -> ~IoTManager();
}

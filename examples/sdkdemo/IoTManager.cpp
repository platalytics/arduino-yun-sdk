#include "IoTManager.h"

IoTManager::IoTManager() {
  _sensorSchema = (String *)0;
}

IoTManager::IoTManager(String *sensorSchema, unsigned int sensorCount , const String &protocolName, unsigned int sensorSchemaLength) {
  _sensorCount = sensorCount;
  _protocolName = protocolName;
  _sensorSchemaLength = sensorSchemaLength;

  _sensorSchema = new String[_sensorSchemaLength];
  for (int i = 0; i < _sensorCount; i++) _sensorSchema[i] = sensorSchema[i];
}

IoTManager::IoTManager(const IoTManager &manager) {
  if (manager._sensorSchema == (String *)0) Serial.println("ERR: passed object is empty!");
  else {
    _sensorCount = manager._sensorCount;
    _protocolName = manager._protocolName;
    _sensorSchemaLength = manager._sensorSchemaLength;

    _sensorSchema = new String[_sensorSchemaLength];
    for (int i = 0; i < _sensorCount; i++) _sensorSchema[i] = manager._sensorSchema[i];
  }
}

void IoTManager::addSensor(const String &sensorTag) {
  if (_sensorCount <= _sensorSchemaLength) _sensorSchema[_sensorCount++] = sensorTag;
  else Serial.println("ERR: sensor array is full!");
}

IoTManager::~IoTManager() {
  if (_sensorSchema) delete[] _sensorSchema;
  _sensorSchema = (String *)0;
  _sensorSchemaLength = 0;
  _protocolName = "";
  _sensorCount = 0;
}

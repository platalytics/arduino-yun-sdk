#include "IoTManager.h"

IoTManager::IoTManager() {
  _sensorSchema = (String *)0;
  _protocolName = "";
  _sensorSchemaLength = 0;
  _sensorCount = 0;
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

// setters
void IoTManager::setSensorSchemaLength(unsigned int sensorSchemaLength) { _sensorSchemaLength = sensorSchemaLength; }
void IoTManager::setProtocol(const String& protocol) { _protocolName = protocol; }

// getters
const String &IoTManager::getProtocolName() { return _protocolName; }
const unsigned int &IoTManager::getSensorCount() { return _sensorCount; }
const unsigned int &IoTManager::getSensorSchemaLength() { return _sensorSchemaLength; }

IoTManager::~IoTManager() {
  if (_sensorSchema) delete[] _sensorSchema;
  _sensorSchema = (String *)0;
  _sensorSchemaLength = 0;
  _protocolName = "";
  _sensorCount = 0;
}

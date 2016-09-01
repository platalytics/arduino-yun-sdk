#ifndef IOTMANAGER_H
#define IOTMANAGER_H

#include <sys/types.h>
#include <string.h>
#include <arduino.h>

class IoTManager {
private:
  String *_sensorSchema;
  unsigned int _sensorCount;
  unsigned int _sensorSchemaLength;
  String _protocolName;

public:
  IoTManager();
  IoTManager(String *, unsigned int, const String&, unsigned int);
  IoTManager(const IoTManager&);

  // setters
  void setSensorSchemaLength(unsigned int);
  void setProtocol(const String&);

  // getters
  const String &getProtocolName();
  const unsigned int &getSensorCount();
  const unsigned int &getSensorSchemaLength();
  
  void addSensor(const String&);
  void connect();
  bool disconnect();
  void sendMessage(const String&);

  ~IoTManager();
};

#endif

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

  void setSensorSchemaLength(int);

  void addSensor(const String&);
  void setProtocol(const String&);
  void connect();
  bool disconnect();
  void sendMessage(const String&);

  ~IoTManager();
};

#endif

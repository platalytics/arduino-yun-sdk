# Arduino Yún SDK

Setup your Arduino Yún device with one of the communication protocols

Add execution permissions to script `arduino­-yun-sdk/deploy.sh`

    $ chmod +x arduino­-yun-sdk/deploy.sh

Run deployment script

    $ ./deploy­.sh <board­-ip> <board­-username> <board-­password> <device-­id> <hub­-id>

This does everything in one go. Sets up protocol libraries and install required dependencies on Arduino board. The next thing you need to do is to upload sketch program through Arduino IDE from your computer.

You can find example sketch programs in `examples/` folder.
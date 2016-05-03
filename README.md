# Arduino Yún SDK

Before you dive in to setting up the **SDK** for your device there are some instructions that need to be followed along.

0. You need to expand your Arduino Yun disk space. For more info and tutorial go to [https://www.arduino.cc/en/Tutorial/ExpandingYunDiskSpace](https://www.arduino.cc/en/Tutorial/ExpandingYunDiskSpace)
1. You need a `linux`-based environment to setup
2. Make sure you have `expect` utility installed

   Get on **Ubuntu** executing following command in terminal

        $ sudo apt-get install expect

Add execution permissions to script `deploy.sh`

    $ chmod +x deploy.sh

Run deployment script

    $ ./deploy.sh <board­ip> <board-username> <board­password> <hub-id> <device-id>

This does everything in one go. Sets up protocol libraries and install required dependencies on Arduino board. The next thing you need to do is to upload sketch program through Arduino IDE from your computer.

You can find example sketch programs in `examples/` folder.
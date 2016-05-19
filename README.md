# Arduino Yún SDK

Before you dive in to setting up the **SDK** for your device there are some instructions that need to be followed along.

1. Expand disk space using `utility/openwrt/diskexpander/memory-expansion.sh`
2. You need a `linux`-based environment to setup
3. Make sure you have `expect` utility installed

    Get on **Ubuntu** executing following command in terminal
        
        $ sudo apt-get install expect

Add execution permissions to script `deploy.sh`

    $ chmod +x deploy.sh

Run deployment script

    $ ./deploy.sh <board-ip> <board-username> <board-password> <device-key> <host> <api-key>

This does everything in one go. Sets up protocol libraries and installs required dependencies on Arduino board. The next thing you need to do is to upload sketch program through Arduino IDE from your computer.

You can find example sketch programs in `examples/` folder.

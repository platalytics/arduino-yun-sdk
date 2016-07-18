# Arduino Yún SDK

Before you dive into setting up the SDK for your device, follow instructions below.

1. Expand disk space using https://www.arduino.cc/en/Tutorial/ExpandingYunDiskSpace
2. You need a Linux based environment (Mac works too) to setup
3. Make sure you have `expect` utility installed

    Get `expect` on Ubuntu/Debian
        
        $ sudo apt-get install expect

Add execution permissions to script `deploy.sh`

    $ chmod +x deploy.sh

Run deployment script

    $ ./deploy.sh -<option1> <value1> ...
        -i IP address
        -u username having root access
        -p password of specified username
        -s SSH port
        -d device ID/key generated from Platalytics Platform
        -f frontend host

Example
    
    $ ./deploy -i 192.168.1.X -u root -p arduino -s 22 -d KEY -f [url]


This does everything in one go. Sets up protocol libraries and installs required dependencies on Arduino board. The next thing you need to do is to upload sketch program to your Arduino board.

You can find example sketch programs in `examples/` folder.
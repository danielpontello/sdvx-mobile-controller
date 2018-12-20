# sdvx-mobile-controller
This repository contains an Android application that serves as a mobile controller for Sound Voltex-like games (like K-Shoot Mania).

Games like these need special controllers to be played correctly, with things like analog knobs that can't be easily emulated with a mouse and keyboard. This project uses the flexibility of touch screens to simulate those controls on a mobile phone/tablet.

![Application running on a mobile phone](/docs/phone.jpg?raw=true "Optional Title")

## Building
### Client
To build the Client, you'll need the [Processing Development Environment](https://processing.org/), as well as the Android SDK (Processing can automagically install it for you). Download the repository and open up the `sdvx_client.pde` file to load the project.

Currently, the IP address of the server is hardcoded on the `sdvx_client/sdvx_client.pde` file. Change it to the IP address of your computer that will be running the game. Build the application and you're ready to go!

### Server

To build the Server, you'll need [Visual Studio Community](https://visualstudio.microsoft.com/pt-br/vs/community/), with the Visual C# environment installed. Open up the `sdvx_server/sdvx_server.sln` file, and the project should load on Visual Studio.

You may need to re-add the references to `SharpOSC.dll` and `vJoyInterfaceWrap.dll` to your project. To do that, right click the "References" item on the Solution Explorer, and click "Add Reference". 

After that, hit "Build" and the program should compile. Make sure your build configuration is set to `x64`, or else the program will fail to run.

## How to Use
### Client

Open up the application on your mobile phone and you are ready to go. Make sure your phone is connected to the same network as your server, and that ports 12000 and 32000 (UDP) are open.

### Server

To run the server, you'll need the [vJoy Virtual Joystick Drivers](http://vjoystick.sourceforge.net/). Those drivers are used to create a virtual device that will be controlled by your mobile phone.

After installing vJoy, open up the "Configure vJoy" application and configure your first virtual joystick as follows:

![vJoy settings screen](/docs/vjoy.png?raw=true "Optional Title")

Open the server application and, if everything is working, it will show the message `[OSC] Now listening to messages.`. Try pressing some buttons on the mobile phone to test if the connection is working properly.

After that, configure your game to use the "vJoy - Virtual Joystick" controller as the main input device. The buttons are mapped as follows:

| Button | vJoy input |
|:------:|:----------:|
| BTN-A  | Button 1   |
| BTN-B  | Button 2   |
| BTN-C  | Button 3   |
| BTN-D  | Button 4   |
| FX-L   | Button 5   |
| FX-R   | Button 6   |
| VOL-L  | Slider 1   |
| VOL-R  | Slider 2   |
| Start  | Button 7   |

## Librares Used

- [OscP5](http://www.sojamo.de/libraries/oscP5/) for sending the OSC messages on the Android app
- [SharpOSC](https://github.com/ValdemarOrn/SharpOSC) for receiving the OSC messages on the Desktop app
- [vJoy C# SDK](https://github.com/shauleiz/vJoy/tree/master/SDK/c%23) for simulating joystick inputs
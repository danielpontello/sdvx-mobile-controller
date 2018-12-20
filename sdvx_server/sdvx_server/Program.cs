using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharpOSC;
using vJoyInterfaceWrap;

namespace sdvx_server
{
    class Program
    {
        static public vJoy joystick;
        static public vJoy.JoystickState iReport;
        static public uint id = 1;

        static float lastL = 0.0f;
        static float currL = 0.0f;

        static float lastR = 0.0f;
        static float currR = 0.0f;

        static float L;
        static float R;

        static void Main(string[] args)
        {
            // VIRTUAL GAMEPAD INITIALIZATION
            Console.WriteLine("[PAD] Initializing gamepad");
            joystick = new vJoy();
            iReport = new vJoy.JoystickState();

            if (!joystick.vJoyEnabled())
            {
                Console.WriteLine("[PAD] vJoy driver not enabled!");
                return;
            }
            else
            {
                Console.WriteLine("[PAD] Vendor: {0}\n[PAD] Product :{1}\n[PAD] Version Number:{2}", joystick.GetvJoyManufacturerString(), joystick.GetvJoyProductString(), joystick.GetvJoySerialNumberString());
            }

            VjdStat status = joystick.GetVJDStatus(id);

            int nButtons = joystick.GetVJDButtonNumber(id);

            if (nButtons < 7)
            {
                Console.WriteLine("[PAD] This app needs at least 7 buttons configured in vJoy to work.");
                return;
            }
            else
            {
                Console.WriteLine("[PAD] Available buttons: " + nButtons);
            }

            bool sliderR = joystick.GetVJDAxisExist(id, HID_USAGES.HID_USAGE_SL0);
            bool sliderL = joystick.GetVJDAxisExist(id, HID_USAGES.HID_USAGE_SL1);

            if(sliderR && sliderL)
            {
                Console.WriteLine("[PAD] Sliders enabled");
            }
            else
            {
                Console.WriteLine("[PAD] This app needs at least 2 sliders configured in vJoy to work.");
                return;
            }

            if ((status == VjdStat.VJD_STAT_OWN) || ((status == VjdStat.VJD_STAT_FREE) && (!joystick.AcquireVJD(id))))
            {
                Console.WriteLine("[PAD] Failed to acquire vJoy device number {0}.", id);
                return;
            }
            else
            {
                Console.WriteLine("[PAD] Acquired: vJoy device number {0}.", id);
            }

            HandleOscPacket callback = delegate (OscPacket packet)
            {
                var messageReceived = (OscMessage)packet;
                string addr = messageReceived.Address;
                string content = messageReceived.Arguments[0].ToString();

                switch (messageReceived.Address)
                {
                    case "/btn-a":
                        if (content == "P")
                            joystick.SetBtn(true, id, 1);
                        if (content == "R")
                            joystick.SetBtn(false, id, 1);
                        break;

                    case "/btn-b":
                        if (content == "P")
                            joystick.SetBtn(true, id, 2);
                        if (content == "R")
                            joystick.SetBtn(false, id, 2);
                        break;

                    case "/btn-c":
                        if (content == "P")
                            joystick.SetBtn(true, id, 3);
                        if (content == "R")
                            joystick.SetBtn(false, id, 3);
                        break;

                    case "/btn-d":
                        if (content == "P")
                            joystick.SetBtn(true, id, 4);
                        if (content == "R")
                            joystick.SetBtn(false, id, 4);
                        break;

                    case "/fx-l":
                        if (content == "P")
                            joystick.SetBtn(true, id, 5);
                        if (content == "R")
                            joystick.SetBtn(false, id, 5);
                        break;

                    case "/fx-r":
                        if (content == "P")
                            joystick.SetBtn(true, id, 6);
                        if (content == "R")
                            joystick.SetBtn(false, id, 6);
                        break;

                    case "/start":
                        if (content == "P")
                            joystick.SetBtn(true, id, 7);
                        if (content == "R")
                            joystick.SetBtn(false, id, 7);
                        break;

                    case "/vol-l":
                        lastL = currL;
                        currL = float.Parse(content);
                        float deltaL = lastL - currL;
                        L -= deltaL;
                        
                        joystick.SetAxis((int)L*500, id, HID_USAGES.HID_USAGE_SL0);
                        break;

                    case "/vol-r":
                        lastR = currR;
                        currR = float.Parse(content);
                        float deltaR = lastR - currR;
                        R -= deltaR;
                        joystick.SetAxis((int)R * 500, id, HID_USAGES.HID_USAGE_SL1);
                        break;
                }
                Console.WriteLine("[OSC] Message Received: Address:" + messageReceived.Address + ", args: " + messageReceived.Arguments[0]);
            };

            var listener = new UDPListener(32000, callback);

            Console.WriteLine("[OSC] Now listening to messages.");
            Console.WriteLine("[OSC] Press enter to stop");
            Console.ReadLine();
            listener.Close();
        }
    }
}

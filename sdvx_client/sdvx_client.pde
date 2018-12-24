import netP5.*;
import oscP5.*;

// Open Sound Control libraries
OscP5 oscP5;
NetAddress serverAddress; 

// Button objects
Button btn_a, btn_b, btn_c, btn_d;
Button fx_l, fx_r;
Button start;

Slider vol_l, vol_r;

// Button colors
color mainBtnColor = color(45, 219, 184);
color fxBtnColor = color(201, 20, 51);
color volLColor = color(107, 241, 253);
color volRColor = color(255, 118, 255);

// Application fonts
PFont mainFont;

float lastRPos;
float currRPos;

float lastLPos;
float currLPos;

void setup()
{
  // oscP5 setup  
  // Change the IP address below to the IP of your computer
  oscP5 = new OscP5(this, 12000);
  serverAddress = new NetAddress("192.168.15.10", 32000);
  
  // Screen setup
  fullScreen();
  orientation(LANDSCAPE);
  smooth(2); 
  
  
  // Layout sizes
  int mainBtnSize = width/4;
  int margins = (height - mainBtnSize)/2;
  
  // Font
  mainFont = createFont("Teko-SemiBold.ttf", 24, true);
  
  // Main buttons
  btn_a = new Button(0, margins, mainBtnSize, mainBtnSize, mainBtnColor, "A");
  btn_b = new Button(mainBtnSize*1, margins, mainBtnSize, mainBtnSize, mainBtnColor, "B");
  btn_c = new Button(mainBtnSize*2, margins, mainBtnSize, mainBtnSize, mainBtnColor, "C");
  btn_d = new Button(mainBtnSize*3, margins, mainBtnSize, mainBtnSize, mainBtnColor, "D");
  
  // FX buttons
  fx_l = new Button(0, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-L");
  fx_r = new Button(mainBtnSize*2, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-R");
  
  // Start button
  start = new Button((width/2)-(margins/4), 0, margins/2, margins, color(0, 0, 255), "S");
  
  // Sliders
  vol_l = new Slider(0, 0, (mainBtnSize*2)-(margins/4), margins, volLColor, "VOL-L");
  vol_r = new Slider((width/2)+(margins/4), 0, mainBtnSize*2-(margins/4), margins, volRColor, "VOL-R");
  
  lastRPos = 0;
  currRPos = 0;
  
  lastLPos = 0;
  currLPos = 0;
}

void draw()
{
  background(15, 28, 36);  
  textFont(mainFont);
  
  // Update button states
  // Main buttons
  btn_a.update();    
  btn_b.update();
  btn_c.update();
  btn_d.update();
  
  // FX Buttons
  fx_l.update();
  fx_r.update();
  
  // Volume Buttons
  vol_l.update();
  vol_r.update();
  
  start.update();
  
  // Send OSC messages
  sendOscMessages();
  
  // Main buttons
  btn_a.draw();    
  btn_b.draw();
  btn_c.draw();
  btn_d.draw();
  
  // FX Buttons
  fx_l.draw();
  fx_r.draw();  
  
  // Volume Buttons
  vol_l.draw();
  vol_r.draw();
  
  // Draw everything
  start.draw();
}

void sendOscMessages()
{
  // Dispatch OSC messages for each of the buttons pressed.
  if(btn_a.justPressed())
  {
    OscMessage msg = new OscMessage("/btn-a");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_a.justReleased())
  {
    OscMessage msg = new OscMessage("/btn-a");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_b.justPressed())
  {
    OscMessage msg = new OscMessage("/btn-b");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_b.justReleased())
  {
    OscMessage msg = new OscMessage("/btn-b");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_c.justPressed())
  {
    OscMessage msg = new OscMessage("/btn-c");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_c.justReleased())
  {
    OscMessage msg = new OscMessage("/btn-c");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_d.justPressed())
  {
    OscMessage msg = new OscMessage("/btn-d");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(btn_d.justReleased())
  {
    OscMessage msg = new OscMessage("/btn-d");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(fx_l.justPressed())
  {
    OscMessage msg = new OscMessage("/fx-l");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(fx_l.justReleased())
  {
    OscMessage msg = new OscMessage("/fx-l");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(fx_r.justPressed())
  {
    OscMessage msg = new OscMessage("/fx-r");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(fx_r.justReleased())
  {
    OscMessage msg = new OscMessage("/fx-r");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }
  
  if(start.justPressed())
  {
    OscMessage msg = new OscMessage("/start");
    msg.add("P");
    oscP5.send(msg, serverAddress);
  }
  
  if(start.justReleased())
  {
    OscMessage msg = new OscMessage("/start");
    msg.add("R");
    oscP5.send(msg, serverAddress);
  }


  // In sliders, we send the current slider position as a float
  if(vol_l.getValue() != 0)
  {
    lastLPos = currLPos;
    currLPos = vol_l.getValue();
    
    if(currLPos != lastLPos)
    {
      OscMessage msg = new OscMessage("/vol-l");
      msg.add(currLPos);
      oscP5.send(msg, serverAddress);
    }
  } else {
    lastLPos = 0;
    currLPos = 0;
  }
  
  if(vol_r.getValue() != 0)
  {
    lastRPos = currRPos;
    currRPos = vol_r.getValue();
    
    if(currRPos != lastRPos)
    {
      OscMessage msg = new OscMessage("/vol-r");
      msg.add(currRPos);
      oscP5.send(msg, serverAddress);
    }
  } else {
    lastRPos = 0;
    currRPos = 0;
  }
}

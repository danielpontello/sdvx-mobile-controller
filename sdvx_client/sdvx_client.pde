import netP5.*;
import oscP5.*;

// Open Sound Control libraries
OscP5 oscP5;
NetAddress serverAddress; 

// Button objects
Button btn_a, btn_b, btn_c, btn_d;
Button fx_l, fx_r;
Button start;

// Button colors
color mainBtnColor = color(42, 154, 108);
color fxBtnColor = color(201, 20, 51);

// Application fonts
PFont mainFont;

void setup()
{
  // oscP5 setup  
  oscP5 = new OscP5(this, 12000);
  serverAddress = new NetAddress("192.168.15.10",32000);
  
  // Screen setup
  fullScreen();
  orientation(LANDSCAPE);
  
  
  // Layout sizes
  int mainBtnSize = width/4;
  int margins = (height - mainBtnSize)/2;
  
  // Font
  mainFont = createFont("Teko-SemiBold.ttf", 36, true);
  
  // Main buttons
  btn_a = new Button(0, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-A");
  btn_b = new Button(mainBtnSize*1, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-B");
  btn_c = new Button(mainBtnSize*2, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-C");
  btn_d = new Button(mainBtnSize*3, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-D");
  
  // FX buttons
  fx_l = new Button(0, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-L");
  fx_r = new Button(mainBtnSize*2, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-R");
  
  // Start button
  start = new Button(0, 0, margins, margins, color(0, 0, 255), "START");
}

void draw()
{
  background(0);  
  textFont(mainFont);
  
  btn_a.update();    
  btn_b.update();
  btn_c.update();
  btn_d.update();
  
  fx_l.update();
  fx_r.update();
  
  start.update();
  
  sendOscMessages();
  
  // Main buttons
  btn_a.draw();    
  btn_b.draw();
  btn_c.draw();
  btn_d.draw();
  
  // FX Buttons
  fx_l.draw();
  fx_r.draw();  
  
  start.draw();
}

void sendOscMessages()
{
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
}

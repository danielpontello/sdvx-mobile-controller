Button btn_a, btn_b, btn_c, btn_d;
Button fx_l, fx_r;

color mainBtnColor = color(42, 154, 108);
color fxBtnColor = color(201, 20, 51);

PFont mainFont;
void setup()
{
  fullScreen();
  orientation(LANDSCAPE);
  
  int mainBtnSize = width/4;
  int margins = (height - mainBtnSize)/2;
  
  mainFont = createFont("Teko-SemiBold.ttf", 36, true);
  
  // main buttons
  btn_a = new Button(0, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-A");
  btn_b = new Button(mainBtnSize*1, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-B");
  btn_c = new Button(mainBtnSize*2, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-C");
  btn_d = new Button(mainBtnSize*3, margins, mainBtnSize, mainBtnSize, mainBtnColor, "BTN-D");
  
  // fx buttons
  fx_l = new Button(0, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-L");
  fx_r = new Button(mainBtnSize*2, margins + mainBtnSize, mainBtnSize*2, margins, fxBtnColor, "FX-R");
}

void draw()
{
  background(0);
  
  
  textFont(mainFont);
  btn_a.draw();
  btn_b.draw();
  btn_c.draw();
  btn_d.draw();
  
  fx_l.draw();
  fx_r.draw();
}
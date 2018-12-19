class Button
{
  int x;
  int y;
  int w;
  int h;
  color mainColor;
  color textColor;
  color currentColor;
  String desc;
  
  public Button(int x, int y, int w, int h, color mainColor, String desc)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.mainColor = mainColor;
    this.currentColor = mainColor;
    this.desc = desc;
  }
  
  public boolean isInside(int x, int y)
  {
    if(x > this.x && x <= this.x + w &&
       y > this.y && y <= this.y + h)
       return true;
    
    return false;
  }
  
  public void update()
  {
    currentColor = mainColor;
    textColor = color(255);
    for (int i = 0; i < touches.length; i++) {
      if(isInside((int)touches[i].x, (int)touches[i].y))
      {
        currentColor = color(255, 255, 255);
        textColor = color(0);
        break;
      }
    }
  }
  
  public void draw()
  {
    update();
    
    fill(currentColor);
    rect(x, y, w, h);
    
    fill(textColor);
    text(desc, x+20, y+50);
  }
}
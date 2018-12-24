class Slider
{
  int x;
  int y;
  int w;
  int h;
  color mainColor;
  color textColor;
  color currentColor;
  String desc;
  
  boolean justPressed;
  boolean justReleased;
  boolean isPressed;
  
  boolean lastPressed;
  boolean currPressed;
  
  int lastPressedPos;
  int currPressedPos;
  
  float currValue;
  float lastValue;
  float delta;
  
  int pressIndex;
  
  int padding = 20;
  
  public Slider(int x, int y, int w, int h, color mainColor, String desc)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.mainColor = mainColor;
    this.currentColor = mainColor;
    this.desc = desc;
    
    justPressed = false;
    justReleased = false;
    lastPressed = false;
    currPressed = false;
    isPressed = false;
    
    lastPressedPos = -1;
    currPressedPos = -1;
    
    currValue = 0;
    lastValue = 0;
    
    pressIndex = -1;
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
    lastPressed = currPressed;
    currPressed = false;
    
    justPressed = false;
    justReleased = false;
    
    currentColor = mainColor;
    textColor = color(255);
    
    for (int i = 0; i < touches.length; i++) {
      if(isInside((int)touches[i].x, (int)touches[i].y))
      {
        currPressed = true;
        currentColor = color(255, 255, 255);
        textColor = color(0);
        pressIndex = i;
        break;
      }
    }
    
    if(lastPressed && !currPressed)
    {
      justReleased = true;
      isPressed = false;
      pressIndex = -1;
      
      lastValue = 0;
      currValue = 0;
    }
      
    if(!lastPressed && currPressed)
    {
      justPressed = true;
      isPressed = true;
      
      currValue = (float)(currPressedPos - x) / (float)w;
      lastValue = currValue;
    }
      
    if(isPressed)
    {
      lastPressedPos = currPressedPos;
      currPressedPos = (int)touches[pressIndex].x;
      
      lastValue = currValue;
      currValue = (float)(currPressedPos - x) / (float)w;
      delta = lastValue - currValue;
    }
    
  }
  
  public float getValue()
  {
    return currValue *200;
  }
  
  public boolean justPressed()
  {
    return justPressed;
  }
  
  public boolean justReleased()
  {
    return justReleased;
  }
  
  public boolean isPressed()
  {
    return justReleased;
  }
  
  public void draw()
  {    
    fill(currentColor);
    rect(x + padding, y + padding, w-(padding*2), h-(padding*2), 10);
    
    textAlign(CENTER, CENTER);
    fill(textColor);
    text(desc, (x+w)/2, (y+h)/2);
    
    if(isPressed)
    {
      fill(127);
      rect(currPressedPos-5, y+padding, 10, h-(padding*2));
    }
    fill(0);
  }
}

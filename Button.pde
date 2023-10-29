CD coll = new CD();

class Button
{
  String Label;
  PVector position;
  PVector size;
  color buttonColor = color(50,50,50);
  
  //------------------------------------------------------------------------------------------------------
  
  Button(String label, PVector position, PVector size)
  {
    this.Label = label;
    this.position = position;
    this.size = size;
  }
  
  //------------------------------------------------------------------------------------------------------
  
  void render()
  {
    strokeWeight(0);
    rectMode(CENTER);
    fill(buttonColor);
    rect(position.x,position.y,size.x,size.y,20);
    fill(0, 408, 612);
    textSize(0.5*size.y);
    textAlign(CENTER);
    text(Label,position.x,position.y+0.1*size.y);
  }
  
  //------------------------------------------------------------------------------------------------------
  
  public void update()
  {
    render();
    if(coll.buttonCD(position,size) == true)
    {
      buttonColor = color(80);
    }
    else
    {
      buttonColor = color(50);
    }
  }
  
}

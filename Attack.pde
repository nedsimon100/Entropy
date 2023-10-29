class Attack
{
  int x = 500;
  int y = 500;
  int size = 40;
  boolean onscreen = true;
  int speed = 20;
  PVector moveDir;

//---------------------------------------------------------------------------------------------------------

  Attack(int tx, int ty)
  {
    tx = tx -500;
    ty = ty -500;
    if(tx<-501)
    {
      onscreen = false;
    }
    moveDir = new PVector((tx/sqrt(pow(tx,2)+pow(ty,2))),(ty/sqrt(pow(tx,2)+pow(ty,2))));
  }
  
  //---------------------------------------------------------------------------------------------------------
  
  private void Render()
  {
    strokeWeight(0);
    fill(0,255,0);
    circle(x, y,size);
    // trail that changes size due to speed
    triangle(x+moveDir.y*20,y-moveDir.x*20,x-moveDir.y*20,y+moveDir.x*20,x-(moveDir.x*40+moveDir.x*speed*2),y-(moveDir.y*40+moveDir.y*speed*2));
  }
  
  //---------------------------------------------------------------------------------------------------------
  
  private void move()
  {
    x += moveDir.x * speed;
    y += moveDir.y * speed;
  }
  
  //--------------------------------------------------------------------------------------------------------
  
    public void bounce(PVector BouncePoint)
  {

      moveDir = new PVector(x-BouncePoint.x,y-BouncePoint.y);
      moveDir = new PVector((moveDir.x/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2))),(moveDir.y/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2))));

    
  }
  
  //-----------------------------------------------------------------------------------------------------------------
  
  public void Update()
  {
    move();
    if(x<-5||x>1005||y<-5||y>height+5)
    {
      onscreen = false;
    }
    Render();
  }
}

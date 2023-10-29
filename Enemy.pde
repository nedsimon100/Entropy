PImage[] enemySprite;


class Enemy{
  
  int x = -50;
  int y = -50;
  int speed = 5;
  int state = 0;
  int size = 50;
  PVector moveDir;
  int animatetimer = 10;
  int animatesprite = 0;

//--------------------------------------------------------------------------------------------------------------------------------------------

  Enemy(PVector target)
  {
    speed = int(random(5,10));
    enemySprite = new PImage[2];
    enemySprite[0] = loadImage("enemy1.png");
    enemySprite[1] = loadImage("enemy2.png");
    enemySprite[0].resize(size-5,size-5);
    enemySprite[1].resize(size-5,size-5);
   int r = int(random(1,5));
   if(r==1)
   {
     x = int(random(0,width));
     y = -50;
   }
   if(r==2)
   {
     x = width + 50;
     y = int(random(0,height));
   }
   if(r==3)
   {
     x = int(random(0,width));
     y = height + 50;
   }
   if(r==4)
   {
     x = -50;
     y = int(random(0,height));
   }

   moveDir = new PVector(target.x-x,target.y-y);
   moveDir = new PVector((moveDir.x/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2)))*speed,(moveDir.y/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2)))*speed);
   
   }
   
   //--------------------------------------------------------------------------------------------------------------------------
   
   Enemy(int x, int y)
   {  
     enemySprite = new PImage[2];
     enemySprite[0] = loadImage("enemy1.png");
     enemySprite[1] = loadImage("enemy2.png");
     enemySprite[0].resize(size-5,size-5);
     enemySprite[1].resize(size-5,size-5);
     moveDir = new PVector(0,0);
     this.x = x;
     this.y = y;
   }
   
   //-------------------------------------------------------------------------------------------------------------------
   
  public void bounce(PVector BouncePoint)
  {

      moveDir = new PVector(x-BouncePoint.x,y-BouncePoint.y);
      moveDir = new PVector((moveDir.x/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2)))*speed,(moveDir.y/sqrt(pow(moveDir.x,2)+pow(moveDir.y,2)))*speed);

    
  }
  
  //----------------------------------------------------------------------------------------------------------------------
  
  public void move()
  {

    
    x += round(moveDir.x);
    y += round(moveDir.y);
  }
  
  //-----------------------------------------------------------------------------------------------------------------
  
  public void render()
  {
    animatetimer--;
    strokeWeight(0);
    fill(255,0,0);
    if(animatetimer<=0)
    {
      animatetimer = 5;
      if(animatesprite == 0){animatesprite = 1;}
      else{animatesprite = 0;}
    }
    image(enemySprite[animatesprite], x-size/2, y-size/2); 
  }
  
//--------------------------------------------------------------------------------------------------------------------

  public void Update()
  {
    move();
    render();
    
  }
  
}

//--------------------------------------------------------------------------------------------------------------------

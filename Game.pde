// Inspector
float speedMult = 0.9;

CD cd = new CD();
ArrayList<Enemy> Enemies;
Target target = new Target();
ArrayList<Attack> attack;
Button[] button;
int gamestate = 0;
int score = -20;
String[] ScoreBoard;
int[] workingScore;
int enemySpawnRate = 4;
int level = 0;
int scoreStrech=0;

//-----------------------------------------------------------------------------------------------

void setup()
{
  frameRate(30);
  size(1000,1000);
  // 
  Enemies = new ArrayList<Enemy>();
  attack = new ArrayList<Attack>();
  button = new Button[6];
  // tutorial enemies
  Enemies.add(new Enemy(300,300));
  Enemies.add(new Enemy(500,250));
  Enemies.add(new Enemy(700,300));
  // attack
  attack.add(new Attack(-20, -20));
  attack.remove(0);
  // menu buttons
  button[0] = new Button("play",new PVector(500, 650),new PVector(200,50));
  button[1] = new Button("leaderboard",new PVector(500, 750),new PVector(200,50));
  button[2] = new Button("quit",new PVector(500, 850),new PVector(200,50));
  button[3] = new Button("back",new PVector(500, 850),new PVector(200,50));
  button[4] = new Button("play again?",new PVector(500, 750),new PVector(200,50));
  button[5] = new Button("main menu",new PVector(500, 850),new PVector(200,50));
  
  // sort leaderBoard
  Leaderboard();
}

//----------------------------------------------------------------------------------------------

void draw()
{
  if (gamestate == 0){mainMenu();}
  if (gamestate == 1){Update();}
  if (gamestate == 2){gameOver();}
}

//----------------------------------------------------------------------------------------------

void Leaderboard()
{
  ScoreBoard = loadStrings("Scores.txt");
  workingScore = new int[ScoreBoard.length];
  workingScore = int(ScoreBoard);
  
  // my own basic sorting algorithm, slightly faster than a bubble sort
  
  if (workingScore.length > 1)
  {
    for(int i = 0; i<workingScore.length-1;i++)
    {
      for(int j = i+1; j<workingScore.length;j++)
      {
        if(workingScore[i]<workingScore[j])
        {
          int temp = workingScore[i];
          workingScore[i] = workingScore[j];
          workingScore[j] = temp;
        }
      }
    }
  }
  saveStrings("Scores.txt", str(workingScore));
  ScoreBoard = loadStrings("Scores.txt");
}

//----------------------------------------------------------------------------------------------

void mainMenu()
{
    background(0);
  // menu based Tutorial
    for (int i = attack.size()-1; i >= 0; i--) 
  { 
    Attack attacki = attack.get(i);
    attacki.Update();
    if(attacki.onscreen == false)
    {
      attack.remove(i);
    }
  }  
    for (int i = Enemies.size()-1; i >= 0; i--) 
    { 
    Enemy enemyi = Enemies.get(i);
    enemyi.Update();
    if(enemyi.x<-100||enemyi.y<-100||enemyi.x>width+100||enemyi.y>height+100)
    {
      Enemies.remove(i);
    }
    }
  fill(255);
  textAlign(CENTER);
  textSize(90);
  text("ENTROPY",500,100);
  textSize(25);
  text("DEFINITELY NOT astroids",825,100);
  textSize(50);
  text("Highscore",500,150);
  textSize(40);
  text(ScoreBoard[0],500,200);
  if(Enemies.size()==0)
  {
  Enemies.add(new Enemy(300,300));
  Enemies.add(new Enemy(500,250));
  Enemies.add(new Enemy(700,300));
  }
  for(int i = 0; i < 3; i++)
  {
    button[i].update();
  }
  target.update();
  collisionCheck();
}

//----------------------------------------------------------------------------------------------

void gameOver()
{
  level = 0;
  enemySpawnRate = 4;
  Leaderboard();
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(90);
  if(score<0)
  {
    text("Leaderboard",500,100);
    button[3].update();
  }
  else
  {
    text("Game Over",500,100);
    textSize(50);
    text("Leaderboard",500,160);
    button[4].update();
    button[5].update();
  }
  textSize(40);
  fill(255);
  boolean scoreRead = false;
  for(int i = 0; i<workingScore.length; i++)
  {    
    if(score == workingScore[i] && scoreRead == false)
    { 
      // highlinght current players score
      fill(0,255,0); 
      scoreRead = true;
    }
    text(ScoreBoard[i],500,220+50*i);
    if(i==9){i = workingScore.length*2;}
    fill(255);
  }
  
}

//----------------------------------------------------------------------------------------------

void Instantiate()
{
  if(level >= 100)
  {
    level = 0;
    scoreStrech = 50;
    enemySpawnRate += 1;
    println(enemySpawnRate);
  }
  float r = random(1,101);
  if(r<enemySpawnRate)
  {
    Enemies.add(new Enemy(new PVector(500,500)));
  }
  
}

//----------------------------------------------------------------------------------------------

void collisionCheck()
{
  for (int j = attack.size()-1; j >= 0; j--) 
  { 
    Attack attackj = attack.get(j);
    for (int i = attack.size()-1; i >= 0; i--) 
    { 
      Attack attacki = attack.get(i);
      if(cd.CollDect(new PVector(attacki.x,attacki.y),new PVector(attackj.x,attackj.y),attacki.size/2,attackj.size/2) == true && i != j)
      {
        // swap speeds
        int a = round(speedMult*attacki.speed);
        attacki.speed = round(speedMult*attackj.speed);
        attackj.speed = a;
        
        attackj.bounce(new PVector(attacki.x,attacki.y));
        attacki.bounce(new PVector(attackj.x,attackj.y));
      }
    }
  }
    for (int j = Enemies.size()-1; j >= 0; j--) 
  { 
    Enemy enemyj = Enemies.get(j);
    for (int i = Enemies.size()-1; i >= 0; i--) 
    { 
      Enemy enemyi = Enemies.get(i);
      if(cd.CollDect(new PVector(enemyi.x,enemyi.y),new PVector(enemyj.x,enemyj.y),enemyi.size/2,enemyj.size/2) == true && i != j)
      {
        int a = round(speedMult*enemyi.speed);
        enemyi.speed = round(speedMult*enemyj.speed);
        enemyj.speed = a;
        
        enemyi.bounce(new PVector(enemyj.x,enemyj.y));
        enemyj.bounce(new PVector(enemyi.x,enemyi.y));
      }
    }
  }
  for (int i = attack.size()-1; i >= 0; i--) 
  { 
    Attack attacki = attack.get(i);
    for (int j = Enemies.size()-1; j >= 0; j--) 
    { 
      Enemy enemyj = Enemies.get(j);
      if(cd.CollDect(new PVector(attacki.x,attacki.y),new PVector(enemyj.x,enemyj.y),attacki.size/2,enemyj.size/2) == true)
      {
        int a = round(speedMult*enemyj.speed);
        enemyj.speed = round(speedMult*attacki.speed);
        attacki.speed = a;
        
        attacki.bounce(new PVector(enemyj.x,enemyj.y));
        enemyj.bounce(new PVector(attacki.x,attacki.y));
      }
    }
  }
}

//----------------------------------------------------------------------------------------------

void Update(){
  if(scoreStrech>0)
  {scoreStrech--;}
  background(0);
  Instantiate();
  
  for (int i = Enemies.size()-1; i >= 0; i--) { 
    Enemy enemyi = Enemies.get(i);
    enemyi.Update();
    if(enemyi.x<-100||enemyi.y<-100||enemyi.x>width+100||enemyi.y>height+100)
    {
      Enemies.remove(i);
      score+=10;
      level+=10;
    }
    if (cd.CollDect(new PVector(width/2,height/2),new PVector(enemyi.x,enemyi.y),15,enemyi.size/2) == true)
    {
      //game Over
      ScoreBoard = append(ScoreBoard, str(score));
      saveStrings("Scores.txt",ScoreBoard);
      gamestate = 2;
    }
  }
  
  
  for (int i = attack.size()-1; i >= 0; i--) 
  { 
    Attack attacki = attack.get(i);
    attacki.Update();
    if(attacki.onscreen == false)
    {
      attack.remove(i);
    }
  }  
    strokeWeight(0);
    fill(30,200,80,90);
    circle(mouseX,mouseY,40);
    fill(255);
    textAlign(CENTER);
    textSize(90+scoreStrech);
    text(str(score),500,100);
    textAlign(LEFT);
    textSize(50);
    text("ammo",30,920);
    for(int i = 0; i < 5-attack.size(); i++)
    {
      fill(30,70,255);
      circle(50+i*50,950,40);
    }
    
    target.update();
    collisionCheck();
}

//----------------------------------------------------------------------------------------------

void mousePressed() 
{
    if(gamestate == 1 && attack.size() < 5)
    {
      attack.add(new Attack(mouseX, mouseY));
      
    }
    if(gamestate == 0)
    {
      if(cd.buttonCD(button[0].position,button[0].size) == true)
      {
        Enemies.clear();
        attack.clear();
        gamestate = 1;
        score = -10*Enemies.size();
      }
      else if(cd.buttonCD(button[1].position,button[1].size) == true)
      {
        Enemies.clear();
        attack.clear();
        gamestate = 2;
      }
      else if(cd.buttonCD(button[2].position,button[2].size) == true)
      {
        exit();
      }
      else if(attack.size() < 5)
      {
        attack.add(new Attack(mouseX, mouseY)); 
      }

    }
    if(gamestate == 2)
    {
      if(cd.buttonCD(button[4].position,button[4].size) == true && score >= 0)
      {
        score = 0;
        Enemies.clear();
        attack.clear();
        gamestate = 1;
      }
      else if(cd.buttonCD(button[3].position,button[3].size) == true)
      {
        score = -10;
        Enemies.clear();
        attack.clear();
        gamestate = 0;
      }
    }
}

PVector playerPos = new PVector(500, 500);

class Target
{

  public void update()
  {
    fill(255);
    strokeWeight(5);
    stroke(255);
    translate(playerPos.x, playerPos.y);
    rotate(atan2(mouseY-playerPos.y, mouseX-playerPos.x));
    quad(0, 0, -10, -10,20,0,-10,10);
    rotate(0);
  }

  
}

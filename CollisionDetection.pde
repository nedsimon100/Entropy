class CD
{
public boolean CollDect(PVector pos1, PVector pos2, int radius1, int radius2)
{
 if(dist(pos1.x,pos1.y, pos2.x,pos2.y) < radius1+radius2)
 {
   return true;
 }
  
  return false;
}

//---------------------------------------------------------------------------------------------------------------------------------
  
  public boolean buttonCD(PVector button, PVector size)
{
 if(mouseX<button.x+(size.x/2) && mouseX>button.x-(size.x/2) && mouseY<button.y+(size.y/2) && mouseY>button.y-(size.y/2))
 {
   return true;
 }
  
  return false;
}
  
  
}

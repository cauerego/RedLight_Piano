class Ball
{
  int x = width/2;
  int y = height/2;
  
  Ball()
  {
  }
  
  void display()
  {
    ellipse(x,y,30,30);
  }
  
  void move()
  {
    x +=3;
    if(x > width)
    {
      x = 0;
      synth.play();
    }
    if(x > width/3)
    {
      synth.stop();
    }
  }
}
 
  

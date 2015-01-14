import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim; 
AudioPlayer player;

int i;
int speed = 10;

void setup()
{
  size(400, 300);
  minim = new Minim(this);
  player = minim.loadFile("tom.aif");
  
}

void draw()
{
  background(0); 
  noStroke();
  
  
  if (i < speed)
  {
    fill(255, 0, 0);
    rect(width/2, height/2, 50, 50);
    player.play();
    player.rewind();
    player.pause();
    player.rewind();
    
    
  }
  if (i > speed)
  {
    fill(0);
    rect(width/2, height/2, 50, 50);
    
  }
  if (i > speed*2)
  {
    i = 0;   
  }
  i++;
}

void stop() {
  super.stop();
}



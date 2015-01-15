import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim; 
AudioPlayer player;

int i;
int speed = 60; // frames

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
  
  
  if (i == 1)
  {
    player.play();
  }
  if (i < speed)
  {
    fill(255, 0, 0);
  }
  if (i > speed)
  {
    fill(0);
  }
  if (i > speed*2)
  {
    i = 0;   
    player.rewind();
  }
  else
  {
    rect(width/2, height/2, 50, 50);
  }
  i++;
}

void stop() {
  super.stop();
}

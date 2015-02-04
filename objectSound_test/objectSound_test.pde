Ball ball;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim       minimSynth;
AudioOutput out;
Noise       noiseStep;
Synth synth;

void setup()
{
  size(400,300);
  ball = new Ball();
  minimSynth = new Minim(this);
  out = minimSynth.getLineOut();
  noiseStep = new Noise(0.05);
  synth = new Synth();
}

void draw()
{
  background(0);
  ball.display();
  ball.move();

}
  

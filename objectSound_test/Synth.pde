class Synth
{
  float gain = 0.05;
  
  Synth()
  {
  }
  
  void play()
  {
    noiseStep.patch(out);
  }
  
  void stop()
  {
    noiseStep.unpatch(out);
  }
}

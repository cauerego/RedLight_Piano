import ddf.minim.*; // for sound
import ddf.minim.ugens.*;
Minim minim, minimSynth; // for sound
AudioOutput out;
Noise       noiseStep;

Settings settings = new Settings();
SongScript songScript = new SongScript();
Grid mainGrid = new Grid();

// normalized millis into seconds and into same momment
// for everything within each common event (setup, draw, etc)
float sTime;

void setup ()
{
    sTime = millis() / 1000.0;
    
    minim = new Minim(this); // for sound
    
    minimSynth = new Minim(this); // for soundSynth
    
    out = minimSynth.getLineOut();
    
    noiseStep = new Noise(0.05);
    
   // Test Synth 
   //noiseStep.patch(out);
    
    settings.Setup();
    
    songScript.Setup();
}

void draw ()
{
    sTime = millis() / 1000.0;
    
    background(0);
    mainGrid.Display();
    
    // display all squares at once
    Square_DisplaySquares(songScript.squaresList, songScript.initialized);
}

void keyPressed ()
{
    songScript.CatchAndSetupEvents(key);
}

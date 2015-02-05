// all for sound
import ddf.minim.*;
import ddf.minim.ugens.*;
Minim minim, minimSynth;
AudioOutput out;

Settings settings = new Settings();
SongScript songScript = new SongScript();
Grid mainGrid = new Grid();

// normalized millis into seconds and into same momment
// for everything within each common event (setup, draw, etc)
float sysTime;

void setup ()
{
    sysTime = millis() / 1000.0;
    
    minim = new Minim(this); // for sound
    
    minimSynth = new Minim(this); // for soundSynth
    
    out = minimSynth.getLineOut();
    
    settings.Setup();
    
    songScript.Setup();
}

void draw ()
{
    sysTime = millis() / 1000.0;
    
    background(0);
    mainGrid.Display();
    
    // display all squares at once
    Square_DisplaySquares(songScript.squaresList, songScript.initialized);
}

void keyPressed ()
{
    songScript.CatchAndSetupEvents(key);
}

void mouseMoved()
{
    // for some reason, "height*2" is the only way to make it work as expected on my mac here, but the *2 shouldn't be needed!
    float opacity = (byte) map( mouseY, 0, height*2, 0, 255 ); // move mouse up and down to set event opacity
    float activate = map( mouseX, 0, width, 0, 1 ); // need to be within an area to be activated
    
    if (activate > 0.5) { // on half screen mouse is active, on the other half it isn't
        Opacity_value = opacity;
    }
    else
    {
        Opacity_value = -1;
    }
}


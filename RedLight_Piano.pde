import ddf.minim.*; // for sound
Minim minim; // for sound

ArrayList renderTheseSquares = new ArrayList();

Grid mainGrid = new Grid();

void setup ()
{
    size (200, 400);
    minim = new Minim(this); // for sound
    
    mainGrid.cellSize = new PVector(10, 10);
    
    SongScript();
}

void draw ()
{
    background(0);
    mainGrid.Display();
    
    // display all squares at once
    DisplaySquares(renderTheseSquares);
}


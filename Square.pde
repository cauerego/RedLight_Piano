class Square 
{
    // properties
    GridCell start; // position and sound
    GridCell end;
    float duration; // how long the square will be on, in seconds
    Grid grid;
    float delay; // how long to hold before displaying the square at first, in seconds
    Blink blink;
//    Opacity opacity;
    
    // variables
    
    private float startTime;
    private PVector pos;
    
    
    // constructor
    
    private void Initialize ()
    {
        startTime = millis();
        blink = null;
    }
    
    private void Initialize (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid)
    {
        Initialize();
        start = cStart;
        end = cEnd;
        duration = cDuration;
        grid = cGrid;
    }
    
    Square () { Initialize(); }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid)
    {
        Initialize(cStart, cEnd, cDuration, cGrid);
    }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid, float cDelay)
    {
        Initialize(cStart, cEnd, cDuration, cGrid);
        delay = cDelay;
    }
    
    // methods
    
    public void Display ()
    {
        if (grid == null) return;
        
        float dur = duration * 1000;
        
        // normalized initial time
        float norm = millis() - (startTime + (delay * 1000));
        float ammt = norm / dur;
        
        if (norm >= 0 && norm < dur)
        {
            //int steps = int( norm % (stepDelay * 1000) );
            //print(start, end, ammt, int(lerp(start.x, end.x, ammt)));
            
            pos = new PVector();
            pos.x = int( lerp(start.pos.x, end.pos.x, ammt) );
            pos.y = int( lerp(start.pos.y, end.pos.y, ammt) );
            
            PVector floatPos = PVector.lerp(start.pos, end.pos, ammt);
            //pos = floatPos; // simpler walking without stepping
            
            // sound and cell verification
            Sound sound = grid.soundArray[int(pos.x)][int(pos.y)];
            if (pos.dist(start.pos) == 0) sound = start.sound;
            if (floatPos.dist(end.pos) < 1) sound = end.sound;
            if (sound != null)
            {
                sound.player.play();
            }
            
            if (blink == null || blink.Okay(norm))
            {
                fill(255,0,0);
                rect(pos.x * grid.cellSize.x, pos.y * grid.cellSize.y, grid.cellSize.x, grid.cellSize.y);
            }
        }
    }
}

// made as public function because couldn't be made as a static method inside class Square
public void DisplaySquares (ArrayList squares)
{
    for (int i = 0; i < squares.size(); i++)
        {
        Square square = (Square) squares.get(i);
        square.Display();
    }
}


class Square 
{
    // properties
    GridCell start; // position and sound
    GridCell end;
    float duration; // how long the square will be on, in seconds
    Grid grid;
    float startTime; // how long to hold before displaying the square at first, in seconds
    Blink blink;
//    Opacity opacity;
    
    // variables
    
    private float initialized;
    private PVector pos;
    private PVector floatPos;
    private GridCell lastCell; // just so we know we moved to a new cell and we can rewind the sound
    
    // constructor
    
    private void Initialize ()
    {
        initialized = millis();
        blink = null;
    }
    
    // minimum needed
    private void Initialize (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid)
    {
        Initialize();
        start = cStart;
        end = cEnd;
        duration = cDuration;
        grid = cGrid;
    }
    
    // maximum possible
    private void Initialize (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid,
      Sound setGridSound, float cStartTime, Blink cBlink)
    {
        Initialize(cStart, cEnd, cDuration, cGrid);
        grid.SetSound(setGridSound);
        startTime = cStartTime;
        blink = cBlink;
    }
    
    Square () { Initialize(); }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid)
    {
        Initialize(cStart, cEnd, cDuration, cGrid);
    }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid, float cStartTime)
    {
        Initialize(cStart, cEnd, cDuration, cGrid, null, cStartTime, null);
    }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid, float cStartTime, Blink cBlink)
    {
        Initialize(cStart, cEnd, cDuration, cGrid, null, cStartTime, cBlink);
    }
    
    Square (GridCell cStart, GridCell cEnd, float cDuration, Grid cGrid,
      Sound setGridSound, float cStartTime, Blink cBlink)
    {
        Initialize(cStart, cEnd, cDuration, cGrid, setGridSound, cStartTime, cBlink);
    }
    
    // methods
    
    public void Display ()
    {
        if (grid == null) return;
        
        float dur = duration * 1000;
        
        // normalized initial time
        float norm = millis() - (initialized + (startTime * 1000));
        float ammt = norm / dur;
        
        if (norm >= 0 && norm < dur)
        {
            //int steps = int( norm % (stepStartTime * 1000) );
            //print(start, end, ammt, int(lerp(start.x, end.x, ammt)));
            
            pos = new PVector();
            pos.x = int( lerp(start.pos.x, end.pos.x, ammt) );
            pos.y = int( lerp(start.pos.y, end.pos.y, ammt) );
            
            floatPos = PVector.lerp(start.pos, end.pos, ammt);
            //pos = floatPos; // simpler walking without stepping
            
            PlaySound();
            
            if (blink == null || blink.Okay(norm))
            {
                fill(255,0,0);
                rect(pos.x * grid.cellSize.x, pos.y * grid.cellSize.y, grid.cellSize.x, grid.cellSize.y);
            }
        }
    }
    
    private void PlaySound ()
    {
        // sound and cell verification: end sound > start sound > grid sound
        Sound sound = grid.soundArray[int(pos.x)][int(pos.y)];
        if (pos.dist(start.pos) == 0) sound = start.sound;
        if (floatPos.dist(end.pos) < 1) sound = end.sound;
        
        // applying lastCell verification
        if (lastCell != null && pos.dist(lastCell.pos) > 0)
        {
            if (lastCell.sound != null) lastCell.sound.Rewind();
        }
        lastCell = new GridCell(pos.x, pos.y);
        lastCell.sound = sound;
        
        // finally play sound if available
        if (sound != null)
        {
            sound.Play();
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


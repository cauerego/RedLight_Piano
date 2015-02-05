class Square 
{
    // properties
    GridCell start; // position and sound
    GridCell end;
    float duration = 0; // how long the square will be on, in seconds
    Grid grid;
    float startTime = 0; // how long to hold before displaying the square at first, in seconds
    Blink blink;
    Opacity opacity;
    
    // variables
    
    public float normTime;
    private Square previousSquare; 
    private PVector pos;
    private PVector floatPos;
    private GridCell lastCell; // just so we know we moved to a new cell and we can rewind the sound
    
    // constructor
    
    private void Initialize ()
    {
        blink = null;
        if (startTime < 0)
        {
            startTime = previousSquare.startTime + previousSquare.duration; // make it start right after the last time
        }
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
      GridSound setGridSound, float cStartTime, Blink cBlink)
    {
        startTime = cStartTime;
        Initialize(cStart, cEnd, cDuration, cGrid);
        grid.SetSound(setGridSound);
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
      GridSound setGridSound, float cStartTime, Blink cBlink)
    {
        Initialize(cStart, cEnd, cDuration, cGrid, setGridSound, cStartTime, cBlink);
    }
    
    private void Initialize (Square oldSquare)
    {
        previousSquare = oldSquare;
        startTime = -1;
    }
    
    Square (Square oldSquare, float cDuration, Blink cBlink)
    {
        Initialize(oldSquare);
        Initialize(previousSquare.end, previousSquare.end, cDuration, previousSquare.grid, null, -1, cBlink);
    }
    
    Square (Square oldSquare, GridCell cEnd, float cDuration, Grid cGrid)
    {
        Initialize(oldSquare);
        Initialize(previousSquare.end, cEnd, cDuration, cGrid);
    }
    
    Square (Square oldSquare, GridCell cEnd, float cDuration, Grid cGrid,
      GridSound setGridSound, float cStartTime, Blink cBlink)
    {
        Initialize(oldSquare);
        Initialize(previousSquare.end, cEnd, cDuration, cGrid, setGridSound, cStartTime, cBlink);
    }
    
    // methods
    
    public void Display (float initialized)
    {
        if (grid == null) return;
        
        // normalized initial time
        normTime = sysTime - (initialized + startTime);
        float ammt = normTime / duration;
        
        if (normTime >= 0 && normTime < duration)
        {
            //int steps = int( normTime % (stepStartTime) );
            //print(start, end, ammt, int(lerp(start.x, end.x, ammt)));
            
            pos = new PVector();
            pos.x = int( lerp(start.pos.x, end.pos.x, ammt) );
            pos.y = int( lerp(start.pos.y, end.pos.y, ammt) );
            
            floatPos = PVector.lerp(start.pos, end.pos, ammt);
            //pos = floatPos; // simpler walking without stepping
            
            PlaySound();
            
            if (blink == null || blink.Okay(normTime)) // this if is meant to work for blinking ...
            {
                // ... but without blinking, only the if would be excluded
                
                float alpha = 255;
                // transparency
                if (opacity != null)
                {
                    alpha = opacity.GetAlpha();
                }
//println(alpha);
                
                fill(255,0,0,alpha);
                rect(pos.x * grid.cellSize.x, pos.y * grid.cellSize.y, grid.cellSize.x, grid.cellSize.y);
            }
        }
    }
    
    private void PlaySound ()
    {
        // sound and cell verification: end sound > start sound > grid sound
        GridSound sound = grid.soundArray[int(pos.x)][int(pos.y)];
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
public void Square_DisplaySquares (ArrayList displaySquares, float initialized)
{
    for (int i = 0; i < displaySquares.size(); i++)
    {
        Square displaySquare = (Square) displaySquares.get(i);
        displaySquare.Display(initialized);
        
        // clean up squares that have already being done, to keep the display square list as short as possible
        if (displaySquare.startTime + displaySquare.duration + 1 < sysTime)
        {
            displaySquares.remove(displaySquare);
        }
    }
}


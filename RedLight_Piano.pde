ArrayList renderTheseSquares = new ArrayList();

Grid grid = new Grid();

void setup ()
{
    size (200, 400);

    grid.cellSize = new PVector(10, 10);
    
    // create the grid, without customizing sounds for each square yet
    for (int x = 0; x < 7; x++)
    {
        for (int y = 0; y < 31; y++)
        {
            if (x == 0 || x == 6 || y < 17)
            {
                Sound sound = new Sound();
                GridCell cell = new GridCell(new PVector(x,y), sound);
                grid.Add(cell);
            }
        }
    }
    
    Blink blink120bpm = new Blink(120);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
    
    // create 2 squares for now
    square = new Square();
    square.start = new PVector(0, 0);
    square.end = new PVector(0, 10);
    square.duration = 5;
    square.grid = grid;
    square.delay = 0;
    
    // add that one square to a list, which could contain many
    renderTheseSquares.add(square);
    
    // then the second square
    square = new Square(
      new PVector(6, 3),
      new PVector(6, 12),
      10,
      grid,
      1);
    square.blink = blink120bpm;
    renderTheseSquares.add(square);
    
    // and so on
    square = new Square();
    square.start = new PVector(3, 0);
    square.end = new PVector(5, 6);
    square.duration = 2;
    square.grid = grid;
    square.delay = 0;
    renderTheseSquares.add(square);
}

void draw ()
{
    background(0);
    grid.Display();
    
    // display all squares at once
    DisplaySquares(renderTheseSquares);
}

class Square 
{
    // properties
    PVector start; // position
    PVector end;
    float duration; // how long the square will be on, in seconds
    Grid grid;
    float delay; // how long to hold before displaying the square at first, in seconds
    Blink blink;
//    Hold hold;
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
    
    private void Initialize (PVector cStart, PVector cEnd, float cDuration, Grid cGrid)
    {
        Initialize();
        start = cStart;
        end = cEnd;
        duration = cDuration;
        grid = cGrid;
    }
    
    Square () { Initialize(); }
    
    Square (PVector cStart, PVector cEnd, float cDuration, Grid cGrid)
    {
        Initialize(cStart, cEnd, cDuration, cGrid);
    }
    
    Square (PVector cStart, PVector cEnd, float cDuration, Grid cGrid, float cDelay)
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
        float norm = millis() - (startTime + (delay*1000));
        float ammt = norm / dur;
        
        if (norm >= 0 && norm < dur)
        {
            //int steps = int( norm % (stepDelay*1000) );
            //print(start, end, ammt, int(lerp(start.x, end.x, ammt)));
            
            pos = new PVector();
            pos.x = int( lerp(start.x, end.x, ammt) );
            pos.y = int( lerp(start.y, end.y, ammt) );
            
            //pos = PVector.lerp(start, end, ammt);
            
            if (blink == null || blink.Okay(norm))
            {
                fill(255,0,0);
                rect(pos.x * grid.cellSize.x, pos.y * grid.cellSize.y, grid.cellSize.x, grid.cellSize.y);
            }
        }
    }
}

public void DisplaySquares (ArrayList squares)
{
    for (int i = 0; i < squares.size(); i++)
        {
        Square square = (Square) squares.get(i);
        square.Display();
    }
}

class Blink
{
    int bpm;
    float delay;
    float duration;
    float blinkAmmt; // from 0 to 1, ammount spent in each blinking state
    Sound sound;
    
    Blink (int cBpm) { Initialize(cBpm, 0, -1, 0.5); }
    Blink (int cBpm, float cDelay, float cDuration)
    {
        Initialize(cBpm, cDelay, cDuration, 0.5);
    }
    Blink (int cBpm, float cDelay, float cDuration, float cBlinkAmmt)
    {
        Initialize(cBpm, cDelay, cDuration, cBlinkAmmt);
    }
    
    public void Initialize (int cBpm, float cDelay, float cDuration, float cBlinkAmmt)
    {
        delay = cDelay * 1000;
        duration = cDuration * 1000;
        bpm = cBpm;
        blinkAmmt = cBlinkAmmt;
    }
    
    public boolean Okay (float init)
    {
        float interval = 1000 / (bpm / 60);
        
        if (init <= delay) return true;
        
        if (duration > 0 && init >= duration + delay) return true;
        
        return norm(millis() % interval, 0, interval) > blinkAmmt;
    }
}


// made to think in just 1 grid, with different sounds
// but also expandable in the future to allows different grids for each square
class Grid
{
    PVector cellSize;
    //ArrayList<PVector> cells = new ArrayList<PVector>();
    ArrayList cells = new ArrayList();
    
    void Add (GridCell cell)
    {
        cells.add(cell);
    }
    
    void Display ()
    {
        for (int i = 0; i < cells.size(); i++)
        //for (GridCell cell in cells)
        {
            GridCell cell = (GridCell) cells.get(i);
            fill(255);
            rect(cell.pos.x * cellSize.x, cell.pos.y * cellSize.y, cellSize.x, cellSize.y);
        }
    }
}

class GridCell
{
    PVector pos; // position
    Sound sound;
    
    GridCell (PVector cPos, Sound cSound)
    {
        pos = cPos;
        sound = cSound;
    }
}

class Sound
{
    float duration;
    //string source;
}


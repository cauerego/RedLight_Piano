import ddf.minim.*; // for sound
Minim minim; // for sound

ArrayList renderTheseSquares = new ArrayList();

Grid grid = new Grid();

void setup ()
{
    size (200, 400);
    minim = new Minim(this); // for sound
    
    grid.cellSize = new PVector(10, 10);
    
    // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("blood_hit");
    
    // create the grid, without customizing sounds for each cell or square yet
    for (int x = 0; x < 7; x++)
    {
        for (int y = 0; y < 31; y++)
        {
            if (x == 0 || x == 6 || y < 19)
            {
                Sound sound = new Sound("blood_splat"); // just leave a default sound for all cells
                GridCell cell = new GridCell(x, y, sound);
                grid.Add(cell);
            }
        }
    }
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
    
    // create first square with a different sound on start
    square = new Square();
    square.start = new GridCell(0, 0, new Sound("Hadouken"));
    square.end = new GridCell(0, 10);
    square.duration = 5;
    square.grid = grid;
    square.delay = 0;
    
    // add that one square to a list, which could contain many
    renderTheseSquares.add(square);
    
    // then the second square
    square = new Square(
      new GridCell(6, 3),
      new GridCell(6, 12),
      10,
      grid,
      1);
    square.blink = blink120bpm;
    renderTheseSquares.add(square);
    
    // and so on
    square = new Square();
    square.grid = grid;
    square.grid.SetSound(null);
    square.start = new GridCell(3, 0);
    square.end = new GridCell(5, 6, new Sound("Hadouken"));
    square.duration = 2;
    renderTheseSquares.add(square);
    
    // 3 more squares to continue the path from the first one
    renderTheseSquares.add( new Square(new GridCell(0, 10), new GridCell(0, 0), 5, grid, 5) );
    renderTheseSquares.add( new Square(new GridCell(0, 0),  new GridCell(0, 5), 4, grid, 10) );
    square = new Square(new GridCell(0, 5),  new GridCell(0, 0), 3, grid, 14); renderTheseSquares.add(square);
    square = new Square(new GridCell(0, 0),  new GridCell(0, 0), 8, grid, 17); square.blink = blink2del3sec; renderTheseSquares.add(square); // simulate hold
}

void draw ()
{
    background(0);
    grid.Display();
    
    // display all squares at once
    DisplaySquares(renderTheseSquares);
}


// -------------- objects


class Square 
{
    // properties
    GridCell start; // position and sound
    GridCell end;
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

class Blink
{
    int bpm;
    float delay;
    float duration;
    float blinkAmmt; // from 0 to 1, ammount spent in each blinking state
    Sound sound;
    
    Blink (int cBpm) { Initialize(cBpm, 0, -1, 0.5, null); }
    Blink (int cBpm, Sound cSound)
    {
        Initialize(cBpm, 0, -1, 0.5, cSound);
    }
    Blink (int cBpm, float cDelay, float cDuration)
    {
        Initialize(cBpm, cDelay, cDuration, 0.5, null);
    }
    Blink (int cBpm, float cDelay, float cDuration, float cBlinkAmmt)
    {
        Initialize(cBpm, cDelay, cDuration, cBlinkAmmt, null);
    }
    Blink (int cBpm, float cDelay, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        Initialize(cBpm, cDelay, cDuration, cBlinkAmmt, cSound);
    }
    
    public void Initialize (int cBpm, float cDelay, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        delay = cDelay * 1000;
        duration = cDuration * 1000;
        bpm = cBpm;
        blinkAmmt = cBlinkAmmt;
        sound = cSound;
    }
    
    public boolean Okay (float init)
    {
        float interval = 60 * 1000 / bpm;
        
        if (init <= delay) return true;
        
        if (duration > 0 && init >= duration + delay) return true;
        
        if (norm(millis() % interval, 0, interval) > blinkAmmt)
        {
            if (sound != null) sound.player.play();
            return true;
        }
        
        if (sound != null) sound.player.rewind();
        return false;
    }
}


// made thinking in just 1 grid, with different sounds
// but also expandable in the future to allow different grids for each square
class Grid
{
    PVector cellSize;
    //ArrayList<PVector> cells = new ArrayList<PVector>();
    ArrayList cells = new ArrayList();
    Sound[][] soundArray = new Sound[99][99]; // little ugly hack to enable finding sound per cell position
    
    void Add (GridCell cell)
    {
        cells.add(cell);
        soundArray[int(cell.pos.x)][int(cell.pos.y)] = cell.sound;
    }
    
    void SetSound (Sound sound)
    {
        for (int i = 0; i < cells.size(); i++)
        {
            GridCell cell = (GridCell) cells.get(i);
            cell.sound = sound;
            soundArray[int(cell.pos.x)][int(cell.pos.y)] = cell.sound;
        }
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
    
    GridCell (float x, float y)
    {
        pos = new PVector(x, y);
        sound = null;
    }
    
    GridCell (float x, float y, Sound cSound)
    {
        pos = new PVector(x, y);
        sound = cSound;
    }
    
    GridCell (float x, float y, String soundName)
    {
        pos = new PVector(x, y);
        sound = new Sound(soundName);
    }
}

class Sound
{
    float duration;
    String source;
    private float lastPlayed;
    private AudioPlayer player;
    
    Sound () {}
    
    Sound (String cSource)
    {
        source = cSource;
        player = minim.loadFile(source + ".mp3");
    }
}


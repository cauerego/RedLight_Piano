// this Grid was made thinking in just 1 grid, with different sounds
// it should be expandable in the future to allow different grids for each square, if that ever makes any sense
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
    
    void SetSound (Sound newSound)
    {
        if (newSound == null) return;
        Sound sound = new Sound(newSound);
        
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
    
    void Initialize (PVector cPos, Sound newSound)
    {
        pos = cPos;
        if (newSound != null)
        {
            sound = new Sound(newSound);
        }
    }
    
    GridCell (PVector cPos, Sound newSound)
    {
        Initialize(cPos, newSound);
    }
    
    GridCell (float x, float y)
    {
        Initialize(new PVector(x, y), null);
    }
    
    GridCell (float x, float y, Sound newSound)
    {
        Initialize(new PVector(x, y), newSound);
    }
    
    GridCell (float x, float y, String soundName)
    {
        Sound sound = null;
        if (soundName != null)
        {
            sound = new Sound(soundName);
        }
        Initialize(new PVector(x, y), sound);
    }
}


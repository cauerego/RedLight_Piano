// this Grid was made thinking in just 1 grid, with different sounds
// it should be expandable in the future to allow different grids for each square, if that ever makes any sense
class Grid
{
    PVector cellSize;
    //ArrayList<PVector> cells = new ArrayList<PVector>();
    ArrayList cells = new ArrayList();
    GridSound[][] soundArray = new GridSound[99][99]; // little ugly hack to enable finding sound per cell position
    
    void Add (GridCell cell)
    {
        cells.add(cell);
        soundArray[int(cell.pos.x)][int(cell.pos.y)] = cell.sound;
    }
    
    void SetSound (GridSound newSound)
    {
        if (newSound == null) return;
        GridSound sound = new GridSound(newSound);
        
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
    GridSound sound;
    
    void Initialize (PVector cPos, GridSound newSound)
    {
        pos = cPos;
        if (newSound != null)
        {
            sound = new GridSound(newSound);
        }
    }
    
    GridCell (PVector cPos, GridSound newSound)
    {
        Initialize(cPos, newSound);
    }
    
    GridCell (float x, float y)
    {
        Initialize(new PVector(x, y), null);
    }
    
    GridCell (float x, float y, GridSound newSound)
    {
        Initialize(new PVector(x, y), newSound);
    }
    
    GridCell (float x, float y, String soundName)
    {
        GridSound sound = null;
        if (soundName != null)
        {
            sound = new GridSound(soundName);
        }
        Initialize(new PVector(x, y), sound);
    }
}


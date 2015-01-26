// this Grid was made thinking in just 1 grid, with different sounds
// it should be expandable in the future to allow different grids for each square, if that ever makes any sense
class Grid
{
    PVector cellSize;
    //ArrayList<PVector> cells = new ArrayList<PVector>();
    ArrayList cells = new ArrayList();
    FileSound[][] soundArray = new FileSound[99][99]; // little ugly hack to enable finding sound per cell position
    
    void Add (GridCell cell)
    {
        cells.add(cell);
        soundArray[int(cell.pos.x)][int(cell.pos.y)] = cell.sound;
    }
    
    void SetSound (FileSound newSound)
    {
        if (newSound == null) return;
        FileSound sound = new FileSound(newSound);
        
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
    FileSound sound;
    
    void Initialize (PVector cPos, FileSound newSound)
    {
        pos = cPos;
        if (newSound != null)
        {
            sound = new FileSound(newSound);
        }
    }
    
    GridCell (PVector cPos, FileSound newSound)
    {
        Initialize(cPos, newSound);
    }
    
    GridCell (float x, float y)
    {
        Initialize(new PVector(x, y), null);
    }
    
    GridCell (float x, float y, FileSound newSound)
    {
        Initialize(new PVector(x, y), newSound);
    }
    
    GridCell (float x, float y, String soundName)
    {
        FileSound sound = null;
        if (soundName != null)
        {
            sound = new FileSound(soundName);
        }
        Initialize(new PVector(x, y), sound);
    }
}


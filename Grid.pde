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


// making this into a class so we can have arbitrary methods within it for repeating sequences
// technically this is meant to create a scope, and remove possibilities of duplicated "global variables"
// probably ideally this would be static class, but there's no need to change everything into static for now
class SongScript
{
    // sound file names, which need to be mp3 within same folder
    Sound blinkNoise;// = new Sound("blood_hit.mp3");
    Sound stepNoise;// = new Sound("blood_splat.mp3");
    Sound startEndNoise;// = new Sound("Hadouken.mp3");
    
    Blink blink120bpm;// = new Blink(120, blinkNoise);
    Blink blink2del3sec;// = new Blink(240, 2, 3);
    
    Square[] square = new Square[2];
    
    // supposed to be executed just once at setup()
    void Setup ()
    {
        blinkNoise = new Sound("bip.aif");
        stepNoise = new Sound("bip.aif");
        startEndNoise = new Sound("bip.aif");
        
        blink120bpm = new Blink(480, blinkNoise);
        blink2del3sec = new Blink(240, 16, 3);
        
        // create the grid, without customizing sounds for each cell or square yet
        for (int x = 0; x < 7; x++)
        {
            for (int y = 0; y < 31; y++)
            {
                if (x == 0 || x == 6 || y < 19)
                {
                    // here, each cell could have a different sound
                    Sound sound = stepNoise; // but we'll just leave a default sound for all cells for now
                    GridCell cell = new GridCell(x, y, sound);
                    mainGrid.Add(cell);
                }
            }
        }
        
        
        // All Rows Back to Front
        for(int i = 0; i < 7; i++)
        {
          if(i > 0 && i < 6)
          {
 // rowMove ->> colNumber, startRow, endRow, speed, starttime
            rowMove(i,i,18,0,1);
          }
          else
          {
          rowMove(i,i,30,0,1);
          }
        }
        
         // All Columns Bouncing  
 // collumnBounce ->> starttime, colNumber, startRow, middlePoint, speed
        collumnBounce(7, 0, 31, 0, 1);
        collumnBounce(9, 1, 19, 0, 1);
        collumnBounce(11,2, 19, 0, 1);
        collumnBounce(13,3, 19, 0, 1);
        collumnBounce(15,4, 19, 0, 1);
        collumnBounce(17,5, 19, 0, 1); 
        collumnBounce(19,6, 31, 0, 1);
        
        // Squares Blinking on First Collumn
  //squareBlink =>> starttime, col, row, duration     
        for(float i = 21; i< 31; i +=1)
        {
          squareBlink(i,0,int(i-21),0.2);
        }
        
        // Squares Blinking on Third Collumn
        
        for(float i = 31; i< 41; i +=0.5)
        {
          squareBlink(i,2,int(i-27),0.2);
        }
        
        // All squares blinking
   //allsquareBlink ==>> starttime, duration
       allsquareBlink(41,5);
        
        //squareHold();
   //squareHold ==>> starttime, col, row, duration
       squareHold(46, 0, 0, 5);
       squareHold(51, 5, 5, 5);
       squareHold(55, 6, 20, 5);
      
       
        //allsquareHold(); 
    //allsquareHold ==>> starttime, duration
        allsquareHold(59,5);

    
    }
    
    void rowMove(float starttime, int colNumber, int startRow, int endRow, float speed)
    {
      square[01] = new Square(new GridCell(colNumber,startRow), new GridCell(colNumber,endRow), speed, mainGrid, stepNoise, starttime, null); renderTheseSquares.add(square[01]);
    }
    
    void collumnBounce(float starttime, int colNumber, int startRow, int middlePoint, float speed)
    {
      square[01] = new Square(new GridCell(colNumber,startRow), new GridCell(colNumber,middlePoint), speed, mainGrid, stepNoise, starttime, null); renderTheseSquares.add(square[01]); 
      square[01] = new Square(square[01], new GridCell(colNumber,startRow), speed, mainGrid); renderTheseSquares.add(square[01]);
    }      
      
    void squareBlink(float starttime, int col, int row, float duration)
    {
      square[01] = new Square(new GridCell(col,row), new GridCell(col,row), duration, mainGrid, starttime); square[01].blink = blink120bpm; renderTheseSquares.add(square[01]);  
    }
    
    void allsquareBlink (float startTime, float duration)
    {
        
        // mostly copied from Grid.Display
        for (int i = 0; i < mainGrid.cells.size(); i++)
        //for (GridCell cell in cells)
        {
            GridCell cell = (GridCell) mainGrid.cells.get(i);
            float col = cell.pos.x;
            float row = cell.pos.y;
            square[01] = new Square(new GridCell(col, row), new GridCell(col,row), duration, mainGrid, startTime); square[01].blink = blink120bpm; renderTheseSquares.add(square[01]);
        }
    }
    
    void squareHold(float starttime, int col, int row, float duration)
    {
      square[01] = new Square(new GridCell(col, row),  new GridCell(col, row), duration, mainGrid, starttime); square[01].blink = blink2del3sec; renderTheseSquares.add(square[01]);
    }
    
    void allsquareHold(float starttime, float duartion)
    {
      for(int row = 0; row < 31; row++)
      {
        for(int col = 0; col < 7; col++)
        {
          square[01] = new Square(new GridCell(col, row), new GridCell(col,row), 10, mainGrid, starttime); square[01].blink = blink2del3sec; renderTheseSquares.add(square[01]);
        }
      }
    }    
}

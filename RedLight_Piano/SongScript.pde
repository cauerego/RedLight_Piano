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
    
    float initialized;
    float simulatedMillis;
    
    // PS: squaresList might easily become much bigger than it needed to be, due to sub optimal conventions here...
    ArrayList squaresList = new ArrayList();
    
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
        simulatedMillis = rMillis / 1000.0;
        for(int i = 0; i < 7; i++)
        {
          if(i > 0 && i < 6)
          {
 // rowMove ->> colNumber, startRow, endRow, duration
            rowMove(i,18,0,1);
          }
          else
          {
          rowMove(i,30,0,1);
          }
        }
        
         // All Columns Bouncing  
 // collumnBounce ->> colNumber, startRow, endRow, duration
        //simulatedMillis = 7;
        collumnBounce(0, 31, 0, 2);
        collumnBounce(1, 19, 0, 2);
        collumnBounce(2, 19, 0, 2);
        collumnBounce(3, 19, 0, 2);
        collumnBounce(4, 19, 0, 2);
        collumnBounce(5, 19, 0, 2); 
        collumnBounce(6, 31, 0, 2);
        
        // Squares Blinking on First Collumn
  //squareBlink =>> col, row, duration
        //simulatedMillis = 21; 
        for(int i = 0; i< 10; i +=1)
        {
          squareBlink(0,i,0.2);
        }
        
        // Squares Blinking on Third Collumn
        simulatedMillis = 31;
        for(int i = 0; i< 10; i +=0.5)
        {
          squareBlink(2,i+4,0.2);
        }
        
        // All squares blinking
   //allsquareBlink ==>> duration
       //simulatedMillis = 41;
       allsquareBlink(5);
        
        //squareHold();
   //squareHold ==>> col, row, duration
       //simulatedMillis = 46;
       squareHold(0, 0, 5);
       squareHold(5, 5, 5);
       squareHold(6, 20, 5);
      
       
        //allsquareHold(); 
    //allsquareHold ==>> duration
        //simulatedMillis = 59;
        allsquareHold(5);

        initialized = rMillis;
    }
    
    // supposed to add squares into the rendering list on the fly, so this should be on draw()
    // PS: after adding this looks like the whole songscript is not starting at 1 rMillis anymore
    void CatchAndSetupEvents (char key)
    {
        if (key == 'A' || key == 'a')
        {
            allsquareBlink( rMillis / 1000.0, 2);
        }
    }
    
    void rowMove(int colNumber, int startRow, int endRow, float duration)
    {
      square[01] = new Square(new GridCell(colNumber,startRow), new GridCell(colNumber,endRow), duration, mainGrid, stepNoise, simulatedMillis, null); squaresList.add(square[01]);
      simulatedMillis += duration;
    }
    
    void collumnBounce(int colNumber, int startRow, int endRow, float duration)
    {
      square[01] = new Square(new GridCell(colNumber,startRow), new GridCell(colNumber,endRow), duration / 2, mainGrid, stepNoise, simulatedMillis, null); squaresList.add(square[01]); 
      square[01] = new Square(square[01], new GridCell(colNumber,startRow), duration / 2, mainGrid); squaresList.add(square[01]);
      simulatedMillis += duration;
    }      
      
    void squareBlink(int col, int row, float duration)
    {
      square[01] = new Square(new GridCell(col,row), new GridCell(col,row), duration, mainGrid, simulatedMillis); square[01].blink = blink120bpm; squaresList.add(square[01]);  
      simulatedMillis += duration;
    }
    
    void allsquareBlink (float duration)
    {
        allsquareBlink(simulatedMillis, duration);
        simulatedMillis += duration * mainGrid.cells.size();
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
            square[01] = new Square(new GridCell(col, row), new GridCell(col,row), duration, mainGrid, startTime); square[01].blink = blink120bpm; squaresList.add(square[01]);
        }
    }
    
    void squareHold(int col, int row, float duration)
    {
      square[01] = new Square(new GridCell(col, row),  new GridCell(col, row), duration, mainGrid, simulatedMillis); square[01].blink = blink2del3sec; squaresList.add(square[01]);
      simulatedMillis += duration;
    }
    
    void allsquareHold(float duration)
    {
      for(int row = 0; row < 31; row++)
      {
        for(int col = 0; col < 7; col++)
        {
          square[01] = new Square(new GridCell(col, row), new GridCell(col,row), duration, mainGrid, simulatedMillis); square[01].blink = blink2del3sec; squaresList.add(square[01]);
          simulatedMillis += duration;
        }
      }
    }    
}

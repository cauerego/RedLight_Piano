// making this into a class so we can have arbitrary methods within it for repeating sequences
// technically this is meant to create a scope, and remove possibilities of duplicated "global variables"
// probably ideally this would be static class, but there's no need to change everything into static for now
class SongScript
{
  // sound file names, which need to be mp3 within same folder
  FileSound blinkNoise;
  FileSound stepNoise;
  FileSound startEndNoise;
  
  Synth stepSynth;

  Blink blinkFast;
  Blink blinkSlowAndStop;
  Blink blinkHold;

  Square[] square = new Square[2];

  float initialized;
  float simulatedTime;

  // PS: squaresList might easily become much bigger than it needed to be, due to sub optimal conventions here...
  ArrayList squaresList = new ArrayList();

  // supposed to be executed just once at setup()
  void Setup ()
  {
    blinkNoise = new FileSound("bip.aif");
    stepNoise = new FileSound("bip.aif");
    startEndNoise = new FileSound("bip.aif");
    
    //stepSynth = new Synth;

    blinkFast = new Blink(480, blinkNoise);
    blinkSlowAndStop = new Blink(240, 1, 4);
    blinkHold = new Blink(1,0,24,0);

    // create the grid, without customizing sounds for each cell or square yet
    for (int x = 0; x < 7; x++)
    {
      for (int y = 0; y < 31; y++)
      {
        if (x == 0 || x == 6 || y < 19)
        {
          // here, each cell could have a different sound
          FileSound sound = stepNoise; // but we'll just leave a default sound for all cells for now
          GridCell cell = new GridCell(x, y, sound);
          mainGrid.Add(cell);
        }
      }
    }

    simulatedTime = millis() / 1000.0;
    
    simulatedTime += 2;
    println(sTime +" ; "+ simulatedTime); // there is a delay between sTime and the beginning of this - my print shows 0.088 ; 2.9
    
    rowHold(0,31,0,1,10);
    
    initialized = sTime; // even if with how sTime works it makes no difference using this in the ending or beginning, it still makes more sense leaving it in the end
  }

  // supposed to add squares into the rendering list on the fly, so this should be on draw()
  // PS: after adding this looks like the whole songscript is not starting at 1 sTime anymore
  void CatchAndSetupEvents (char key)
  {
    if (key == 'A' || key == 'a')
    {
      allsquareBlink(sTime, 2);
    }
  }
  
  void colControl(int colNumber, float duration, int alpha)
  {
    if((colNumber == 0)||(colNumber == 6)) 
    {
      square[01] = new Square(new GridCell(colNumber, 31), new GridCell(colNumber, 0), duration, mainGrid, stepNoise, simulatedTime, null); 
      square[01].opacity = new Opacity(square[01], 0.7, 2.1, alpha, alpha);
      squaresList.add(square[01]); 
      simulatedTime += duration;
    }
     if((colNumber > 0)&&(colNumber < 6)) 
    {
      square[01] = new Square(new GridCell(colNumber, 19), new GridCell(colNumber, 0), duration, mainGrid, stepNoise, simulatedTime, null); 
      square[01].opacity = new Opacity(square[01], 0.7, 2.1, alpha, alpha);
      squaresList.add(square[01]); 
      simulatedTime += duration;
    } 
  }

  void rowMove(int colNumber, int startRow, int endRow, float duration)
  {
    square[01] = new Square(new GridCell(colNumber, startRow), new GridCell(colNumber, endRow), duration, mainGrid, stepNoise, simulatedTime, null);
    square[01].opacity = new Opacity(square[01], 0.7, 2.1, 250, 10);
    squaresList.add(square[01]);
    simulatedTime += duration;
  }

  void collumnBounce(int colNumber, int startRow, int endRow, float duration)
  {
    square[01] = new Square(new GridCell(colNumber, startRow), new GridCell(colNumber, endRow), duration / 2, mainGrid, stepNoise, simulatedTime, null); 
    squaresList.add(square[01]); 
    square[01] = new Square(square[01], new GridCell(colNumber, startRow), duration / 2, mainGrid); 
    squaresList.add(square[01]);
    simulatedTime += duration;
  }      

  void squareBlink(int col, int row, float duration)
  {
    square[01] = new Square(new GridCell(col, row), new GridCell(col, row), duration, mainGrid, simulatedTime); 
    square[01].blink = blinkFast; 
    squaresList.add(square[01]);  
    simulatedTime += duration;
  }

  void allsquareBlink (float duration)
  {
    allsquareBlink(simulatedTime, duration);
    simulatedTime += duration;
  }
  void allsquareBlink (float startTime, float duration)
  {

    // mostly copied from Grid.Display
    for (int i = 0; i < mainGrid.cells.size (); i++)
      //for (GridCell cell in cells)
    {
      GridCell cell = (GridCell) mainGrid.cells.get(i);
      float col = cell.pos.x;
      float row = cell.pos.y;
      square[01] = new Square(new GridCell(col, row), new GridCell(col, row), duration, mainGrid, startTime); 
      square[01].blink = blinkFast; 
      squaresList.add(square[01]);
    }
  }

  void squareHold(int col, int row, float duration)
  {
    square[01] = new Square(new GridCell(col, row), new GridCell(col, row), duration, mainGrid, simulatedTime); 
    square[01].blink = blinkHold; 
    squaresList.add(square[01]);
    simulatedTime += duration;
  }

  void allsquareHold(float duration)
  {
    for (int row = 0; row < 31; row++)
    {
      for (int col = 0; col < 7; col++)
      {
        square[01] = new Square(new GridCell(col, row), new GridCell(col, row), duration, mainGrid, simulatedTime); 
        square[01].blink = blinkSlowAndStop; 
        squaresList.add(square[01]);
        simulatedTime += duration;
      }
    }
  }
  
  void randomSquares(float duration)
  {
    for(float i = 0.0; i < 100.0; i +=0.05)
    {
      int randomColumn = int(random(7));
      int randomTime = int(random(20));
      float randomDur = int(random(1));
      if(randomColumn == 0 || randomColumn == 6)
      {
         int randomRow = int(random(10,31));
         square[01] = new Square(new GridCell(randomColumn, randomRow), new GridCell(randomColumn, randomRow), duration, mainGrid, i); 
         square[01].blink = blinkHold; 
         squaresList.add(square[01]);
         simulatedTime += duration;
      }
               
  else
     {
         int randomRow = int(random(19));
         square[01] = new Square(new GridCell(randomColumn, randomRow), new GridCell(randomColumn, randomRow), duration, mainGrid, i); 
         square[01].blink = blinkHold; 
         squaresList.add(square[01]);
         simulatedTime += duration;
     }
    }
  }
  
  void rowHold(int colNumber, int startRow, int endRow, float duration, float holdDuration)
  {
    square[01] = new Square(new GridCell(colNumber, startRow), new GridCell(colNumber, endRow), duration, mainGrid, stepNoise, simulatedTime, null);
    square[01].opacity = new Opacity(square[01], 0.7, 2.1, 250, 10);
    squaresList.add(square[01]);
    simulatedTime += duration;
    square[01] = new Square(new GridCell(colNumber, endRow), new GridCell(colNumber, endRow), holdDuration, mainGrid, simulatedTime); 
    square[01].blink = blinkHold; 
    squaresList.add(square[01]);
    simulatedTime += duration;
  }
}


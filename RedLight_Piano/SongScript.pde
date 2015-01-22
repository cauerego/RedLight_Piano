// supposed to be executed just once at setup()
void SongScript ()
{
    // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
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
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
    
    LBF(0);
    oneBF(1);
    twoBF(2);
    threeBF(3);
    fourBF(4);
    fiveBF(5);
    RBF(6);
}


void LBF(int starttime)
{
   // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
    
    
   // LEFT Back to Front Fast
    square = new Square();
    square.start = new GridCell(0, 31, startEndNoise);
    square.end = new GridCell(0, 0);
    square.duration = 1;
    square.grid = mainGrid;
    square.delay = starttime;
    // add that one square to a list, which will contain many
    renderTheseSquares.add(square);
}


void oneBF(int starttime)
{
 // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
        
  // 1 Back to Front Fast
    square = new Square(
      new GridCell(1, 19),
      new GridCell(1, 0),
      1,
      mainGrid,
      starttime);
    square.blink = blink120bpm;
    renderTheseSquares.add(square);
}

void twoBF(int starttime)
{
   // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square;
    
    // 2 Back to Front Fast
    square = new Square();
    square.grid = mainGrid;
    square.grid.SetSound(null);
    square.start = new GridCell(2, 19);
    square.end = new GridCell(2, 0, startEndNoise);
    square.duration = 1;
    square.delay = starttime;
    renderTheseSquares.add(square);
}

void threeBF(int starttime)
{
  // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square; 
  
  // 3 Back to Front Fast
    renderTheseSquares.add( new Square(new GridCell(3, 19), new GridCell(3, 0), 1, mainGrid, stepNoise, starttime, null) );
}

void fourBF(int starttime)
{
  // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square; 
  // 4 Back to Front Fast
    renderTheseSquares.add( new Square(new GridCell(4, 19),  new GridCell(4, 0), 1, mainGrid, stepNoise, starttime, null) );
}

void fiveBF(int starttime)
{
  // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square; 
  
  // 5 Back to Front Fast
    square = new Square(new GridCell(5, 19),  new GridCell(5, 0), 1, mainGrid, starttime); renderTheseSquares.add(square);
}

void RBF(int starttime)
{
  // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test.aif");
    Sound stepNoise = new Sound("bip.aif");
    Sound startEndNoise = new Sound("silence_test.aif");
    
    Blink blink120bpm = new Blink(120, blinkNoise);
    Blink blink2del3sec = new Blink(240, 2, 3);
    
    Square square; 
    
    // RIGHT Back to Front Fast
    square = new Square(new GridCell(6, 31),  new GridCell(6, 0), 1, mainGrid, starttime); renderTheseSquares.add(square); // simulate hold
}


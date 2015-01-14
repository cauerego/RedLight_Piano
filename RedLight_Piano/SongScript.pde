// supposed to be executed just once at setup()
void SongScript ()
{
    // sound file names, which need to be mp3 within same folder
    Sound blinkNoise = new Sound("silence_test");
    Sound stepNoise = new Sound("click");
    Sound startEndNoise = new Sound("click");
    
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
    
    // create first square with a different sound on start
    square = new Square();
    square.start = new GridCell(0, 0, startEndNoise);
    square.end = new GridCell(0, 15);
    square.duration = 5;
    square.grid = mainGrid;
    square.delay = 0;
    // add that one square to a list, which will contain many
    renderTheseSquares.add(square);
    
  /*
    // then the second square
    square = new Square(
      new GridCell(6, 0),
      new GridCell(6, 15),
      5,
      mainGrid,
      0);
    square.blink = blink120bpm;
    renderTheseSquares.add(square);
    */
    
    // and so on
    square = new Square();
    square.grid = mainGrid;
    square.grid.SetSound(null);
    square.start = new GridCell(1, 0);
    square.end = new GridCell(1, 15, startEndNoise);
    square.duration = 5;
    renderTheseSquares.add(square);
    
    
    // 4 more squares to continue the path from the first one, made in different possible ways
    renderTheseSquares.add( new Square(new GridCell(2, 15), new GridCell(2, 0), 5, mainGrid, stepNoise, 0, null) );
    renderTheseSquares.add( new Square(new GridCell(3, 15),  new GridCell(3, 0), 5, mainGrid, stepNoise, 0, null) );
    square = new Square(new GridCell(4, 0),  new GridCell(4, 15), 5, mainGrid, 0); renderTheseSquares.add(square);
    square = new Square(new GridCell(5, 0),  new GridCell(5, 15), 5, mainGrid, 0); square.blink = blink2del3sec; renderTheseSquares.add(square); // simulate hold
  
}

// supposed to be executed just once at setup()
void SongScript ()
{
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
    
    // 4 more squares to continue the path from the first one
    renderTheseSquares.add( new Square(new GridCell(0, 10), new GridCell(0, 0), 5, grid, 5) );
    renderTheseSquares.add( new Square(new GridCell(0, 0),  new GridCell(0, 5), 4, grid, 10) );
    square = new Square(new GridCell(0, 5),  new GridCell(0, 0), 3, grid, 14); renderTheseSquares.add(square);
    square = new Square(new GridCell(0, 0),  new GridCell(0, 0), 8, grid, 17); square.blink = blink2del3sec; renderTheseSquares.add(square); // simulate hold
}

class Opacity
{
    Square square;
    float startTime = 0;
    float duration;
    int startOpacity;
    int endOpacity;
    
    void Initialize (Square cSquare, float cStartTime, float cDuration, int cStartOpacity, int cEndOpacity)
    {
        square = cSquare;
        startTime = cStartTime;
        duration = cDuration;
        startOpacity = cStartOpacity;
        endOpacity = cEndOpacity;
    }
    
    Opacity (Square cSquare, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, 0, square.duration, cStartOpacity, cEndOpacity);
    }
    
    Opacity (Square cSquare, float cDuration, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, 0, cDuration, cStartOpacity, cEndOpacity);
    }
    
    Opacity (Square cSquare, float cStartTime, float cDuration, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, cStartTime, cDuration, cStartOpacity, cEndOpacity);
    }
    
    float GetAlpha ()
    {
        float normStart = startTime + sysTime - square.normTime;
        float ammt = norm(sysTime, normStart, normStart + duration);
//println(sysTime +" ; "+ ammt +" ; "+ norm); 
        return lerp(startOpacity, endOpacity, ammt);
    }
}

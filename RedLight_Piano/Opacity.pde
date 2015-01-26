class Opacity
{
    Square square;
    float duration;
    int startOpacity;
    int endOpacity;
    
    Opacity (Square cSquare, int cStartOpacity, int cEndOpacity)
    {
        square = cSquare;
        duration = square.duration;
        startOpacity = cStartOpacity;
        endOpacity = cEndOpacity;
    }
    
    float GetAlpha ()
    {
        float norm = sTime - square.normTime;
        float ammt = norm(sTime, norm, norm + duration);
//println(sTime +" ; "+ ammt +" ; "+ norm); 
        return lerp(startOpacity, endOpacity, ammt);
    }
}

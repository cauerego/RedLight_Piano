// since I don't know how to add a static value into Opacity class
public float Opacity_value = -1; // static, from 0 to 255

class Opacity
{
    Square square;
    float startTime = 0;
    float duration;
    int startOpacity;
    int endOpacity;
    boolean useStatic = false;
    
    void Initialize (Square cSquare, float cStartTime, float cDuration, int cStartOpacity, int cEndOpacity, boolean cUseStatic)
    {
        square = cSquare;
        startTime = cStartTime;
        duration = cDuration;
        startOpacity = cStartOpacity;
        endOpacity = cEndOpacity;
        useStatic = cUseStatic;
    }
    
    Opacity (Square cSquare)
    {
        Initialize(cSquare, 0, cSquare.duration, 255, 255, true); // basically to use static
    }
    
    Opacity (Square cSquare, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, 0, cSquare.duration, cStartOpacity, cEndOpacity, false);
    }
    
    Opacity (Square cSquare, int cStartOpacity, int cEndOpacity, boolean cUseStatic)
    {
        Initialize(cSquare, 0, cSquare.duration, cStartOpacity, cEndOpacity, cUseStatic);
    }
    
    Opacity (Square cSquare, float cDuration, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, 0, cDuration, cStartOpacity, cEndOpacity, false);
    }
    
    Opacity (Square cSquare, float cDuration, int cStartOpacity, int cEndOpacity, boolean cUseStatic)
    {
        Initialize(cSquare, 0, cDuration, cStartOpacity, cEndOpacity, cUseStatic);
    }
    
    Opacity (Square cSquare, float cStartTime, float cDuration, int cStartOpacity, int cEndOpacity)
    {
        Initialize(cSquare, cStartTime, cDuration, cStartOpacity, cEndOpacity, false);
    }
    
    Opacity (Square cSquare, float cStartTime, float cDuration, int cStartOpacity, int cEndOpacity, boolean cUseStatic)
    {
        Initialize(cSquare, cStartTime, cDuration, cStartOpacity, cEndOpacity, cUseStatic);
    }
    
    float GetAlpha ()
    {
        if (useStatic && Opacity_value >= 0)
        {
            return Opacity_value;
        }
        else
        {
            float normStart = startTime + sysTime - square.normTime;
            float ammt = norm(sysTime, normStart, normStart + duration);
//println(sysTime +" ; "+ ammt +" ; "+ norm); 
            return lerp(startOpacity, endOpacity, ammt);
        }
    }
}

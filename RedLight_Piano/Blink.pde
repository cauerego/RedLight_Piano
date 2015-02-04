// if defined, will make the Square blink
// this is a subclass to Square
class Blink
{
    int bpm; // beats per minute
    float startTime;
    float duration;
    float blinkAmmt; // from 0 to 1, ammount spent in each blinking state
    FileSound sound;
    
    Blink (int cBpm) { Initialize(cBpm, 0, -1, 0.5, null); }
    Blink (int cBpm, FileSound cSound)
    {
        Initialize(cBpm, 0, -1, 0.5, cSound);
    }
    Blink (int cBpm, float cStartTime, float cDuration)
    {
        Initialize(cBpm, cStartTime, cDuration, 0.5, null);
    }
    Blink (int cBpm, float cStartTime, float cDuration, float cBlinkAmmt)
    {
        Initialize(cBpm, cStartTime, cDuration, cBlinkAmmt, null);
    }
    Blink (int cBpm, float cStartTime, float cDuration, float cBlinkAmmt, FileSound cSound)
    {
        Initialize(cBpm, cStartTime, cDuration, cBlinkAmmt, cSound);
    }
    
    public void Initialize (int cBpm, float cStartTime, float cDuration, float cBlinkAmmt, FileSound cSound)
    {
        startTime = cStartTime;
        duration = cDuration;
        bpm = cBpm;
        blinkAmmt = cBlinkAmmt;
        sound = cSound;
    }
    
    public boolean Okay (float normTime)
    {
        float interval = 60 * 1000 / bpm; // magical formula to calculate the bpm into mili seconds
        if (normTime < startTime) return true;
        
        if (duration > 0 && normTime > duration + startTime) return true;
        
        if (norm((sysTime * 1000) % interval, 0, interval) > blinkAmmt)
        {
            if (sound != null) sound.Play();
            return true;
        }
        
        if (sound != null) sound.Rewind();
        return false;
    }
}


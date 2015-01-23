// to-do: make it simpler to read and understand

class Blink
{
    int bpm;
    float startTime;
    float duration;
    float blinkAmmt; // from 0 to 1, ammount spent in each blinking state
    Sound sound;
    
    Blink (int cBpm) { Initialize(cBpm, 0, -1, 0.5, null); }
    Blink (int cBpm, Sound cSound)
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
    Blink (int cBpm, float cStartTime, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        Initialize(cBpm, cStartTime, cDuration, cBlinkAmmt, cSound);
    }
    
    public void Initialize (int cBpm, float cStartTime, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        startTime = cStartTime * 1000;
        duration = cDuration * 1000;
        bpm = cBpm;
        blinkAmmt = cBlinkAmmt;
        sound = cSound;
    }
    
    public boolean Okay (float init)
    {
        float interval = 60 * 1000 / bpm;
        
        if (init <= startTime) return true;
        
        if (duration > 0 && init >= duration + startTime) return true;
        
        if (norm(millis() % interval, 0, interval) > blinkAmmt)
        {
            if (sound != null) sound.Play();
            return true;
        }
        
        if (sound != null) sound.Rewind();
        return false;
    }
}


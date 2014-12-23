class Blink
{
    int bpm;
    float delay;
    float duration;
    float blinkAmmt; // from 0 to 1, ammount spent in each blinking state
    Sound sound;
    
    Blink (int cBpm) { Initialize(cBpm, 0, -1, 0.5, null); }
    Blink (int cBpm, Sound cSound)
    {
        Initialize(cBpm, 0, -1, 0.5, cSound);
    }
    Blink (int cBpm, float cDelay, float cDuration)
    {
        Initialize(cBpm, cDelay, cDuration, 0.5, null);
    }
    Blink (int cBpm, float cDelay, float cDuration, float cBlinkAmmt)
    {
        Initialize(cBpm, cDelay, cDuration, cBlinkAmmt, null);
    }
    Blink (int cBpm, float cDelay, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        Initialize(cBpm, cDelay, cDuration, cBlinkAmmt, cSound);
    }
    
    public void Initialize (int cBpm, float cDelay, float cDuration, float cBlinkAmmt, Sound cSound)
    {
        delay = cDelay * 1000;
        duration = cDuration * 1000;
        bpm = cBpm;
        blinkAmmt = cBlinkAmmt;
        sound = cSound;
    }
    
    public boolean Okay (float init)
    {
        float interval = 60 * 1000 / bpm;
        
        if (init <= delay) return true;
        
        if (duration > 0 && init >= duration + delay) return true;
        
        if (norm(millis() % interval, 0, interval) > blinkAmmt)
        {
            if (sound != null) sound.player.play();
            return true;
        }
        
        if (sound != null) sound.player.rewind();
        return false;
    }
}


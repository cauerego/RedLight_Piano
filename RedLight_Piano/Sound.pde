class Sound
{
    float duration = 500; // default to half second (500)
    String source;
    private AudioPlayer player;
    float startedPlaying = -1;
    
    void Initialize (String cSource, float cDuration)
    {
        source = cSource;
        duration = cDuration;
        player = minim.loadFile(source);
    }

    Sound (String cSource) { Initialize(cSource, duration); }
    
    Sound (String cSource, float cDuration)
    {
        Initialize(cSource, cDuration);
    }

    Sound (Sound cSound)
    {
        Initialize(cSound.source, cSound.duration);
    }
    
    void Play ()
    {
        if (startedPlaying < 0 || rMillis > startedPlaying + duration)
        {
            player.play();
            startedPlaying = rMillis;
        }
    }
    
    void Rewind ()
    {
        startedPlaying = -1;
        player.rewind();
    }
}


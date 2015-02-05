class GridSound
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

    GridSound (String cSource) { Initialize(cSource, duration); }
    
    GridSound (String cSource, float cDuration)
    {
        Initialize(cSource, cDuration);
    }

    GridSound (GridSound cSound)
    {
        Initialize(cSound.source, cSound.duration);
    }
    
    void Play ()
    {
        if (startedPlaying < 0 || sysTime > startedPlaying + duration)
        {
            player.play();
            startedPlaying = sysTime;
        }
    }
    
    void Rewind ()
    {
        startedPlaying = -1;
        player.rewind();
    }
}


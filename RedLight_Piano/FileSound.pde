class FileSound
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

    FileSound (String cSource) { Initialize(cSource, duration); }
    
    FileSound (String cSource, float cDuration)
    {
        Initialize(cSource, cDuration);
    }

    FileSound (FileSound cSound)
    {
        Initialize(cSound.source, cSound.duration);
    }
    
    void Play ()
    {
        if (startedPlaying < 0 || sTime > startedPlaying + duration)
        {
            player.play();
            startedPlaying = sTime;
        }
    }
    
    void Rewind ()
    {
        startedPlaying = -1;
        player.rewind();
    }
}


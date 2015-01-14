class Sound
{
    float duration = -1;
    String source;
    private AudioPlayer player;
    
    void Initialize (String cSource, float cDuration)
    {
        source = cSource;
        duration = cDuration;
        player = minim.loadFile(source + ".mp3");
    }

    Sound (String cSource) { Initialize(cSource, -1); }
    
    Sound (String cSource, float cDuration)
    {
        Initialize(cSource, cDuration);
    }

    Sound (Sound cSound)
    {
        Initialize(cSound.source, cSound.duration);
    }
}


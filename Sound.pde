class Sound
{
    float duration;
    String source;
    private float lastPlayed;
    private AudioPlayer player;
    
    Sound () {}
    
    Sound (String cSource)
    {
        source = cSource;
        player = minim.loadFile(source + ".mp3");
    }
}


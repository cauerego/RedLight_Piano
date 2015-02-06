// A GridSound is either from a file source or a synth oscil wave - can't be both!
class GridSound
{
    float duration = 500; // default to half second (500)
    float startedPlaying = -1;
    
    // a GridSound is either this OR wave - can't be both
    String fileSource; 
    private AudioPlayer player;
    
    // if there's a wave set, it will be prefered over fileSource
    Wave wave;
    
    void Initialize (String cFileSource, float cDuration)
    {
        fileSource = cFileSource;
        duration = cDuration;
        player = minim.loadFile(fileSource);
    }
    
    void Initialize (float cFrequency, float cAmplitude, Waveform cWaveform, float cDuration)
    {
        duration = cDuration;
        wave = new Wave( cFrequency, cAmplitude, cWaveform, cDuration );
    }

    GridSound (GridSound cSound)
    {
        if (cSound.wave != null)
        {
            Initialize(cSound.wave.frequency, cSound.wave.amplitude, cSound.wave.waveform, cSound.duration);
            //Initialize(cSound.wave.frequency.getLastValues()[0], cSound.wave.amplitude.getLastValues()[0], cSound.wave.getWaveform(), cSound.duration);

        }
        else
        {
            Initialize(cSound.fileSource, cSound.duration);
        }
    }

    GridSound (String cFileSource) { Initialize(cFileSource, duration); }
    
    GridSound (String cFileSource, float cDuration)
    {
        Initialize(cFileSource, cDuration);
    }
    
    GridSound (float cFrequency, float cAmplitude, Waveform cWaveform, float cDuration)
    {
        Initialize(cFrequency, cAmplitude, cWaveform, cDuration);
    }
    
    void Play ()
    {
        if (startedPlaying < 0 || sysTime > startedPlaying + duration)
        {
            if (wave != null)
            {
                wave.play(); // this starts playing and never stops
            }
            else
            {
                player.play(); // this plays until the end of file, and stop
            }
            startedPlaying = sysTime;
        }
    }
    
    void FixSound () {
        Rewind();
        /*
        startedPlaying = -1;
        if (player != null)
        {
            player.rewind();
        }
        */
    }
    
    void Rewind ()
    {
        startedPlaying = -1;
        if (player != null)
        {
            player.rewind();
        }
        if (wave != null)
        {
            wave.rewind();
        }
    }
}


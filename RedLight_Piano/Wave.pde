//Wave Wave_allWaves[] = new Wave[99];
ArrayList Wave_allWavesPlaying = new ArrayList();

class Wave
{
    float frequency;
    float amplitude;
    Waveform waveform;
    Oscil oscil;
    float started;
    float duration;
    
    Wave (float cFrequency, float cAmplitude, Waveform cWaveform, float cDuration)
    {
        frequency = cFrequency;
        amplitude = cAmplitude;
        waveform = cWaveform;
        duration = cDuration;
        oscil = new Oscil( cFrequency, cAmplitude, cWaveform );
    }
    
    void play ()
    {
        started = sysTime;
        oscil.patch(out);
        Wave_allWavesPlaying.add(this);
    }
    
    void rewind ()
    {
        oscil.unpatch(out);
        Wave_allWavesPlaying.remove(this);
    }
}

void Wave_Update ()
{
    for (int i = 0; i < Wave_allWavesPlaying.size(); i++)
    {
        Wave wave = (Wave) Wave_allWavesPlaying.get(i);
        if (wave.started + wave.duration < sysTime)
        {
            wave.rewind();
        }
    }
}

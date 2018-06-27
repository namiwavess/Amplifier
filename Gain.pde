class Gain implements AudioEffect
{
  float gain = 5.0;

  Gain(float g)
  {
    gain = g;
  }
  void process(float[] samp)
  {
    float[] out = new float[samp.length];
    for ( int i = 0; i < samp.length; i++ )
    {
      out[i] = samp[i] * gain;
    }
    arraycopy(out, samp);
  }
   void process(float[] left, float[] right)//
  {
    process(left);
    process(right);
  }
}

class Reverb implements AudioEffect
{
  float[] l_buffer;//変数の宣言 
  float[] r_buffer;//
  int buffer_size;//バッファの大きさ
  int l_index, r_index;//バッファを入れるインデックス
  float reverbtime;//
  int feedback;//
  float[] reverblevel;//
  
  Reverb(float fs, float dt, float dl, int fb)
  {
    reverbtime = fs * dt;
    feedback = fb;
    buffer_size = (int)(reverbtime * feedback) + 1;
    
    l_index = 0;
    r_index = 0;
    
    l_buffer = new float[buffer_size];
    r_buffer = new float[buffer_size];
    
    for (int i = 0; i < buffer_size; i++)
    {
      l_buffer[i] = 0.0;
      r_buffer[i] = 0.0;
    }
    
    reverblevel = new float[feedback];
    
    for (int i = 0; i < feedback; i++)
    {
      reverblevel[i] = pow(dl, (float)(i + 1) );
    }
  }
  
  int echo_process(float[] samp, float[] buffer, int ix)
  {
    int index = ix;
    float[] out = new float[samp.length];
    for ( int n = 0; n < samp.length; n++ )
    {
      buffer[index] = samp[n];
      float data = samp[n];
      for (int i = 0; i < feedback; i++)
      {
        int m = index - (int)((i + 1) * reverbtime);
        if ( m < 0 )
        {
          m += buffer_size;
        }
        data += reverblevel[i] * buffer[m];
      }
      out[n] = data;
      index++;
      if (index >= buffer_size)
      {
        index = 0;
      }
    }    
    arraycopy(out, samp);
    
    return index;
  }

  void process(float[] samp)
  {
    l_index = echo_process(samp, l_buffer, l_index);
  }
  
  void process(float[] left, float[] right)
  {
    l_index = echo_process(left, l_buffer, l_index);
    r_index = echo_process(right, r_buffer, r_index);
  }
}

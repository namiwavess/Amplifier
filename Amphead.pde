//Reproduction of guitar amp.
//Adjust the amount of distortion, high frequency range, bass range, distortion effect, reverberation effect on guitar.wav in the file.
//Overflow should be prevented, but since it is a guitar amp, it will dare to eliminate the restriction in order to produce distorted sound.
//We also visualize the waveform.

import ddf.minim.*;
import ddf.minim.effects.*;

float FREQUENCY = 44000.0;
float LIMITLOW = 300.0;
float LOW = 5.0;
float LIMITHIGH = 5000.0;
float HIGH = 3.0;
float GAIN = 1.2;
float REVERBTIME = 0.1;
float REVERBLEVEL = 0.5;
int FEEDBACK = 4;

Minim minim;
AudioPlayer player;
Gain gain;
Bass bass;
Treble treble;
Reverb reverb;

void setup()
{
  size(1000, 200);
  minim = new Minim(this);
  player = minim.loadFile("guitar.wav", 1024);
  gain = new Gain(GAIN);
  bass = new Bass(FREQUENCY, LIMITLOW, LOW);//
  treble = new Treble(FREQUENCY, LIMITHIGH, HIGH);//
  reverb = new Reverb(FREQUENCY, REVERBTIME, REVERBLEVEL, FEEDBACK);
  player.addEffect(gain);
  player.addEffect(bass);
  player.addEffect(treble);
  player.addEffect(reverb);
  player.play();
}

void draw()
{
  background(255);
  stroke(0);
  for(int i = 0; i < player.left.size()-1; i++)
  {
    line(i, 30 + player.left.get(i)*50, i+1, 50 + player.left.get(i+1)*50);
    line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i+1)*50);
  }

}

void stop()//
{
  player.close();
  minim.stop();

  super.stop();
}

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
FFT fft;

int colorBrightness = 3;
int hue = 0;
int sampleSize = 2048;
int scale = 20;
float[] yValuesPrev;
float SunWidth = 500;
float AU = 215 * SunWidth;

Camera cam = new Camera();

void setup()
{
  size(800, 500, P3D);
  stroke(255);
  minim = new Minim(this);
  player = minim.loadFile("Music1.mp3", sampleSize);
  meta = player.getMetaData();
  player.play();
  
  yValuesPrev = new float[sampleSize];
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw()
{
  float brightness = 3;
  float sky = 255 * player.mix.level();
  float blue = 255;
  float red = random(200, 255) * brightness * player.mix.level();
  float green = random(100, 200) * brightness * player.mix.level();
  
  background(0, 0, sky);
  
  textSize(12);
  fill(255);
  text("Title: " + meta.title(), 0, 0);
  text("Author: " + meta.author(), 0, 23);
  
  cam.update();
  stroke(red, green, 0);
  pushMatrix();
  fill(red, green, 0);
  rotateY(millis()/1000.0);
  sphere(SunWidth * (1 - player.mix.level()));
  popMatrix();
}
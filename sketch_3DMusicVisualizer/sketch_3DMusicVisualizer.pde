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
  float blue = random(100, 255) * brightness * player.mix.level();
  float red = random(100, 255) * brightness * player.mix.level();
  float green = random(100, 255) * brightness * player.mix.level();
  
    hue += 2;
  while (hue >= 360) hue -= 360;
  stroke(hue, 255, 255);

  int stepForward = sampleSize / scale;
  int max = yValuesPrev.length - stepForward;
  for (int i = 0; i < max; i++) {
    yValuesPrev[i] = yValuesPrev[i+stepForward];
  }

  float baseY = height/2;
  int x = 0;
  for (int i = 0; i < player.bufferSize (); i+=scale) {
    float y = baseY + player.mix.get(i) * 100;

    if (max + x < yValuesPrev.length - 1) {
      yValuesPrev[max + x] = y;
    } else {
      yValuesPrev[yValuesPrev.length - 1] = y;
    }
    x++;
  }
  
  background(0, sky, 0);
  
  textSize(12);
  fill(255);
  text("Title: " + meta.title(), 150, 15);
  text("Author: " + meta.author(), 150, 28);
  
  cam.update();
  pushMatrix();
  translate(400, 0, 0);
  fill(0, 0, blue);
  rotateX(millis()/1000.0);
  box(50,50,50);
  translate(-1224, 0, 0);
  beginShape();
  fill(0, green, blue);
  for (int i = 0; i < yValuesPrev.length; i++) {
    vertex(i, yValuesPrev[i]);
  }
  endShape(); 
  
  rotateX(-2 * millis()/1000.0);
  
  beginShape();
  fill(red, green, 0);
  for (int i = 0; i < yValuesPrev.length; i++) {
    vertex(i, yValuesPrev[i]);
  }
  endShape();
  
  translate(824, 0, 0);
  fill(red, 0, 0);
  box(50,50,50);
  
  popMatrix();
}
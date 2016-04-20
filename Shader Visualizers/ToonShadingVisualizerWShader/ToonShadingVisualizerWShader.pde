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

PShader toon;

void setup()
{
  size(640, 360, P3D);
  noStroke();
  fill(204);
  minim = new Minim(this);
  player = minim.loadFile("Music.mp3", 2048);
  meta = player.getMetaData();
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  toon = loadShader("frag.glsl", "vert.glsl");
  toon.set("fraction", 1.0);
}

void draw()
{
  shader(toon);
  background(0);
  float dirY = (mouseY / float(height) - 0.5) * 30 * player.mix.level();
  float dirX = (mouseX / float(width) - 0.5) * 30 * player.mix.level();
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  sphere(120);
}
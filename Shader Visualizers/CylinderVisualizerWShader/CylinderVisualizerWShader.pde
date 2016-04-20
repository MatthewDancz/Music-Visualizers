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

PImage label;
PShape can;
float angle;
PShader colorShader;

void setup() {
  size(640, 360, P3D);
  label = loadImage("slopokeTail.png");
  can = createCan(100, 200, 32, label);
  minim = new Minim(this);
  player = minim.loadFile("Music.mp3", 2048);
  meta = player.getMetaData();
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  colorShader = loadShader("colorFrag.glsl", "colorVert.glsl");
}

void draw() {  
  float sky = 255 * (.8 - player.mix.level());
  if (mouseX > width/2)
  {
    background(sky, 0, 0);
  }
  else if(mouseY > height/2)
  {
    background(0, sky, 0);
  }  
  else
  {
    background(0, 0, sky);
  }
  
  if (mouseX > width/2 && mouseY > height/2)
  {
    background(sky, sky, 0);
  }

  shader(colorShader);
  translate(width/2, height/2);
  rotateY(angle);
  shape(can);  
  angle -= 0.01;
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}
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
//Sun and Base stats
float SunRadius = 30;
float AU = SunRadius * 3.34;
float SpeedBase = 1000;

//Mercury Base Stats
float Mercury = 0.0034 * SunRadius;
float MercuryOrbit = AU * 0.4;
float MercurySpeed = 1.607;

//Venus Base Stats
float Venus = 0.0087 * SunRadius;
float VenusOrbit = AU * 0.7;
float VenusSpeed = 1.174;

//Earth Base Stats
float Earth = 0.0091 * SunRadius;
float EarthOrbit = AU;
float EarthSpeed = 1;

//Mars Base Stats
float Mars = 0.0048 * SunRadius;
float MarsOrbit = AU * 1.5;
float MarsSpeed = 0.802;

//Jupiter Base Stats
float Jupiter = 0.1026 * SunRadius;
float JupiterOrbit = AU * 5.2;
float JupiterSpeed = 0.434;

//Saturn Base Stats
float Saturn = 0.0862 * SunRadius;
float SaturnOrbit = AU * 9.5;
float SaturnSpeed = 0.323;

//Uranus Base Stats
float Uranus = 0.055 * SunRadius;
float UranusOrbit = AU * 19.2;
float UranusSpeed = 0.228;

//Neptune Base Stats
float Neptune = 0.037 * SunRadius;
float NeptuneOrbit = AU * 30.1;
float NeptuneSpeed = 0.182;

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
  float red = random(200, 255) * brightness * player.mix.level();
  float green = random(100, 200) * brightness * player.mix.level();
  float blue = 255;
  float BaseSpeed = millis();
  
  //SunRadius = 1000 * player.mix.level();
  
  background(0, 0, sky);
  
  textSize(12);
  fill(255);
  text("Title: " + meta.title(), 50, -8);
  text("Author: " + meta.author(), 50, 15);
  
  cam.update();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase);
  fill(red, green, 0);
  stroke(red, green, 0);
  sphere(SunRadius * (1 - player.mix.level()));
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * MercurySpeed);
  fill(169, 169, 169);
  stroke(169, 169, 169);
  translate(MercuryOrbit, 0, 0);
  sphere(Mercury);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * VenusSpeed);
  fill(238, 232, 170);
  stroke(238, 232, 170);
  translate(VenusOrbit, 0, 0);
  sphere(Venus);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * EarthSpeed);
  fill(0, 0, blue);
  stroke(0, 0, blue);
  translate(EarthOrbit, 0, 0);
  sphere(Earth);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * MarsSpeed);
  fill(165, 93, 53);
  stroke(165, 93, 53);
  translate(MarsOrbit, 0, 0);
  sphere(Mars);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * JupiterSpeed);
  fill(255, 165, 0);
  stroke(255, 165, 0);
  translate(JupiterOrbit, 0, 0);
  sphere(Jupiter);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * SaturnSpeed);
  fill(218, 165, 32);
  stroke(218, 165, 32);
  translate(SaturnOrbit, 0, 0);
  sphere(Saturn);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * UranusSpeed);
  fill(65, 105, 225);
  stroke(65, 105, 225);
  translate(UranusOrbit, 0, 0);
  sphere(Uranus);
  popMatrix();
  
  pushMatrix();
  rotateY(BaseSpeed/SpeedBase * NeptuneSpeed);
  fill(65, 105, 255);
  stroke(65, 105, 255);
  translate(NeptuneOrbit, 0, 0);
  sphere(Neptune);
  popMatrix();
}
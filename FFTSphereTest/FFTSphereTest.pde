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

int count = 0;

void setup()
{
  size(500, 500);
  stroke(255);
  minim = new Minim(this);
  player = minim.loadFile("Music1.mp3", 2048);
  meta = player.getMetaData();
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  background(0);
}

void draw()
{
  float blue = (255 + mouseX) * player.mix.level();
  float red = (255 + mouseY) * player.mix.level();
  float green = (255 + mouseY) * player.mix.level();
  float pokemonBlue = (255 + mouseX) * player.mix.level();
  float pokemonRed = (255 + mouseX) * player.mix.level();
  float pokemonGreen = (255 + mouseY) * player.mix.level();
  
  //World Space
  stroke(0);
  
  fill(red, green, blue);
  
  for (int i = 0; i < 5; i++)
  {
    ellipse(random(0, width), random(0, height), 50 * i * player.mix.level(), 50 * i * player.mix.level());
    rect(random(0, width), random(0, height), 50 * i * player.mix.level(), 50 * i * player.mix.level());
    triangle(500 * i * player.mix.level(), 50 * i * player.mix.level(), 500 * i * player.mix.level(), 500 * i * player.mix.level(), 50 * i * player.mix.level(), 500 * i * player.mix.level());
  }
  
  fill(pokemonRed, pokemonGreen, 0);
  rect(20, height - 130, 500 * player.mix.level(), 500 * player.mix.level());
  
  fill(pokemonGreen, pokemonRed, 0);
  if (mouseX > mouseY)
  {
    fill(0, 0, pokemonBlue);
  }
  rect(width - 130, 20, 500 * player.mix.level(), 500 * player.mix.level());
  
  fill(255);
  
  //Screen Space
  textSize(12);
  text("Title: " + meta.title(), 5, 15);
  text("Author: " + meta.author(), 5, 28);
}
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

SnowFlake[] SnowFlakes = new SnowFlake[10000];
int count = 0;

PShader shader;
PImage image1;

void setup()
{
  size(500, 500, P2D);
  stroke(255);
  minim = new Minim(this);
  player = minim.loadFile("Music2.mp3", 2048);
  meta = player.getMetaData();
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  image1 = loadImage("trogdor.png");
  shader = loadShader("desat.txt");
}

void draw()
{
  float sky = 255 * player.mix.level();
  float blue = random(0, 200) * mouseY/50 * player.mix.level();
  float white = 255 * 3 * player.mix.level();
  float red = mouseX * mouseY/50 * player.mix.level();
  float green = mouseY * mouseY/50 * player.mix.level();
  background(0, 0, sky);
  shader.set("desatAmount", 1 - player.mix.level());
  image(image1, 500 * player.mix.level(), height/5);
  
  //World Space
  stroke(0);
  
  fill(red, green, blue);
  
  ellipse(width/2, height/2 + 80, 500 * player.mix.level(), 500 * player.mix.level());
  ellipse(width/2, (height/2 + 45) - 200 * player.mix.level(), 50, 50);
  
  if (fft.specSize() > 1000)
  {
    SnowFlakes[count] = new SnowFlake(random(-200, 700), 0, random(2, 5), random(2, 5), random(1,3), count);
    count++;
  }

  if (player.mix.level() > .4)
  {
    textSize(32);
    fill(255);
    text("Punched a Canadian!!!", width / 5, height / 5);
    textSize(12);
  }
  
  for(SnowFlake n : SnowFlakes)
  {
    if (n != null)
    {
      n.originY = n.originY + n.fallSpeed; 
      n.originX = n.originX + (mouseX - width/2) / 100;
      fill(white);
      n.Display();
      if (n.MeltingPoint() > height)
      {
        n.ToMelt(true);
      }
    }
  }
  
  if (SnowFlakes[0].MeltMe())
  {
    count--;
    for(int i = 0; i < count; i++)
    {
      if (SnowFlakes[i] == null)
      {
        break;
      }      
      SnowFlakes[i] = SnowFlakes[i + 1];
    }
  }
  
  fill(255);
  
  //Screen Space
  textSize(12);
  text("Title: " + meta.title(), 5, 15);
  text("Author: " + meta.author(), 5, 28);
  
  filter(shader);
}
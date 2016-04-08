class SnowFlake
{
  boolean meltMe = false;
  
  float originX;
  float originY;
  float snowHeight;
  float snowWidth;
  float fallSpeed;
  int index;
  
  SnowFlake(float x, float y, float z, float w, float v, int i)
  {
    originX = x;
    originY = y;
    snowHeight = z;
    snowWidth = w;
    fallSpeed = v;
    index = i;
  }
  
  void Display()
  {
    ellipse(originX, originY, snowHeight, snowWidth);
  }
  
  public void ToMelt(boolean t) { meltMe = t; }
  public int getIndex() { return index; }
  public float MeltingPoint() { return originY; }
  public boolean MeltMe() { return meltMe; }
}
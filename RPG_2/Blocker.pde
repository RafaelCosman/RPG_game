class Blocker
{
  PVector loc;
  int bulletSize;

  Blocker(PVector loc, int bulletSize)
  {
    this.loc = loc;
    this.bulletSize = bulletSize;
  }

  void show()
  {
    fill(0);
    ellipse(loc.x, loc.y, bulletSize, bulletSize);
  }
}


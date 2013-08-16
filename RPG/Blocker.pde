class Blocker
{
  PVector loc;
  int bSize;

  Blocker(PVector loc, int bSize)
  {
    this.loc = loc;
    this.bSize = bSize;
  }

  void show()
  {
    fill(0);
    ellipse(loc.x, loc.y, bSize, bSize);
  }

  void run()
  {
  }
}


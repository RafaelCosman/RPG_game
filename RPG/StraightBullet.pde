class StraightBullet extends Bullet
{
  PVector shootLoc;
  int range;

  StraightBullet(PVector shootLoc, PVector vel, PVector loc, int bulletSize, int damage, int range, float speed, boolean madeByPlayer, boolean piercing)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, piercing);
    this.shootLoc = shootLoc;
    this.range = range;
  }
  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(0, 255, 255);
    super.show();
  }

  void run()
  {
    super.run();
    //vel.limit(3.5);
  }
}


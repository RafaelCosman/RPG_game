class CircleyBullet extends Bullet
{
  PVector shootLoc;
  int range;
  float rotateAmount;

  CircleyBullet(PVector shootLoc, PVector vel, PVector loc, int bulletSize, int damage, int range, float rotateAmount, float speed, boolean madeByPlayer, boolean piercing)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, piercing);
    this.shootLoc = shootLoc;
    this.range = range;
    this.rotateAmount = rotateAmount;
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(0, 127.5, 127.5);
      
    super.show();
  }

  void run()
  {
    super.run();

    float m = vel.mag();
    float a = vel.heading2D();
    a += rotateAmount;

    vel.x = m * cos(a);
    vel.y = m * sin(a);
  }
}


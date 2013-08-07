class CircleyBullet extends Bullet
{
  PVector shootLoc;
  int range;
  float rotateAmount;

  CircleyBullet(PVector shootLoc, PVector vel, PVector loc, int bulletSize, int damage, int range, float rotateAmount, float speed, boolean madeByPlayer, boolean exists, boolean piercing)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, exists, piercing);
    this.shootLoc = shootLoc;
    this.range = range;
    this.rotateAmount = rotateAmount;
  }

  void show()
  {
    fill(0);
    super.show();
  }

  void run()
  {
    super.run();
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) < b.bulletSize / 2 + (bulletSize / 2))
        exists = false;
    }

    float m = vel.mag();
    float a = vel.heading2D();
    a += rotateAmount;

    vel.x = m * cos(a);
    vel.y = m * sin(a);

    loc.add(vel);
  }
}


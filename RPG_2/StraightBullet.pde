class StraightBullet extends Bullet
{
  PVector shootLoc;
  int range;

  StraightBullet(PVector shootLoc, PVector vel, PVector loc, int bulletSize, int damage, int range, float speed, boolean madeByPlayer, boolean exists, boolean piercing)
  {
    super();
    this.shootLoc = shootLoc;
    this.range = range;
  }
  void show()
  {
    fill(0);
    super.show();
  }

  void run()
  {
    vel.x = dist(loc.x, 0, p.loc.x, 0);
    vel.y = dist(0, loc.y, 0, p.loc.y);
    vel.limit(2);
    if (loc.x - p.loc.x > 0)
      loc.x -= vel.x;
    else
      loc.x += vel.x;
    if (loc.y - p.loc.y > 0)
      loc.y -= vel.y;
    else
      loc.y += vel.y;
    fill(255, 0, 0);
    ellipse(loc.x, loc.y, bulletSize, bulletSize);
    vel.limit(3.5);
    loc.add(vel);
  }
}


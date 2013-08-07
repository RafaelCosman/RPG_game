class FollowBullet extends Bullet
{
  int surviveTimeCurrent, surviveTimeDeadline;

  FollowBullet(PVector vel, PVector loc, int bulletSize, int damage, float speed, int surviveTimeCurrent, int surviveTimeDeadline, boolean madeByPlayer, boolean exists, boolean piercing)
  {
    super();
    this.surviveTimeCurrent = surviveTimeCurrent;
    this.surviveTimeDeadline = surviveTimeDeadline;
  }

  void show()
  {
    fill(0);
    super.show();
  }

  void run()
  {
    if (millis() - surviveTimeCurrent - pauseTime >= surviveTimeDeadline)
      exists = false;
    vel.limit(speed);
    if (!madeByPlayer)
    {
      if (p.loc.x < vel.x)
        vel.x -= 100;
      if (p.loc.x > vel.x)
        vel.x += 100;
      if (p.loc.y < vel.y)
        vel.y -= 100;
      if (p.loc.y > vel.y)
        vel.y += 100;
    }
    loc.add(vel);
  }
}


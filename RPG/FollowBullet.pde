class FollowBullet extends Bullet
{
  int surviveTimeCurrent, surviveTimeDeadline;

  FollowBullet(PVector vel, PVector loc, int bulletSize, int damage, float speed, int surviveTimeCurrent, int surviveTimeDeadline, boolean madeByPlayer, boolean piercing)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, piercing);
    this.surviveTimeCurrent = surviveTimeCurrent;
    this.surviveTimeDeadline = surviveTimeDeadline;
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(255, 0, 0);
      
    super.show();
  }

  void run()
  {
    super.run();

    if (millis() - surviveTimeCurrent - pauseTime >= surviveTimeDeadline)
      exists = false;
    vel.limit(speed);
    if (!madeByPlayer)
    {
      if (p.loc.x < vel.x)
        vel.x -= 99;
      if (p.loc.x > vel.x)
        vel.x += 99;
      if (p.loc.y < vel.y)
        vel.y -= 99;
      if (p.loc.y > vel.y)
        vel.y += 99;
    }
  }
}


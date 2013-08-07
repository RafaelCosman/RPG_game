class WigglyBullet extends Bullet
{
  PVector wiggleVel;
  int wiggleAmount, wiggleChangeTime;
  float rotateAmount;
  boolean hasWiggled;

  WigglyBullet(PVector wiggleVel, PVector vel, PVector loc, int bulletSize, int damage, int range, int wiggleAmount, int wiggleChangeTime, float rotateAmount, float speed, boolean madeByPlayer, boolean exists, boolean piercing)
  {
    super(vel, loc, bulletSize, damage, speed, madeByPlayer, piercing);
    
    this.wiggleVel = wiggleVel;
    this.wiggleAmount = wiggleAmount;
    this.wiggleChangeTime = wiggleChangeTime;
    this.rotateAmount = rotateAmount;
    this.hasWiggled = false;
  }

  void show()
  {
    if (madeByPlayer)
      fill(0, 255, 0);
    else
      fill(127.5, 0, 255);
    
    super.show();
  }

  void run()
  {
    super.run();

    vel.limit(speed);
    if (millis() - wiggleChangeTime - pauseTime >= wiggleChangeTime)
    {
      float m = wiggleAmount;
      float a = vel.heading2D();
      if (!hasWiggled)
      {
        a += rotateAmount / 2;
        hasWiggled = true;
        wiggleVel.x = m * cos(a);
        wiggleVel.y = m * sin(a);
      } else 
      {
        a = wiggleVel.heading2D();
        a += rotateAmount;
        wiggleVel.x = m * cos(a);
        wiggleVel.y = m * sin(a);
      }
      wiggleChangeTime = millis() - pauseTime;
    }
    loc.add(wiggleVel);
  }
}


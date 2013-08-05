class Bullet
{
  PVector shootLoc, loc1, loc2, wiggleVel;
  int bSize, surviveTimeCurrent, surviveTimeDeadline, damage, range, wiggleAmount, wiggleChangeTime;
  float speed;
  boolean madeByPlayer, madeByEnemyA, madeByEnemyB, madeByEnemyC, madeByEnemyD, exists, piercing, hasWiggled;

  Bullet(PVector shootLoc, PVector loc1, PVector loc2, PVector wiggleVel, int bSize, int surviveTimeCurrent, int surviveTimeDeadline, int damage, int range, int wiggleAmount, int wiggleChangeTime, float speed, boolean madeByPlayer, boolean madeByEnemyA, boolean madeByEnemyB, boolean madeByEnemyC, boolean madeByEnemyD, boolean exists, boolean piercing, boolean hasWiggled)
  {
    this.shootLoc = shootLoc;
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.wiggleVel = wiggleVel;
    this.bSize = bSize;
    this.surviveTimeCurrent = surviveTimeCurrent;
    this.surviveTimeDeadline = surviveTimeDeadline;
    this.damage = damage;
    this.range = range;
    this.wiggleAmount = wiggleAmount;
    this.wiggleChangeTime = wiggleChangeTime;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.madeByEnemyA = madeByEnemyA;
    this.madeByEnemyB = madeByEnemyB;
    this.madeByEnemyC = madeByEnemyC;
    this.madeByEnemyD = madeByEnemyD;
    this.exists = exists;
    this.piercing = piercing;
    this.hasWiggled = hasWiggled;
  }

  void show()
  {
    if (madeByPlayer)
    {
      loc1.limit(3.5);
      loc2.add(loc1.x, loc1.y, 0);
      fill(0, 255, 0);
    }
    else if (madeByEnemyA)
    {
      loc1.x = dist(loc2.x, 0, p.loc2.x, 0);
      loc1.y = dist(0, loc2.y, 0, p.loc2.y);
      loc1.limit(1);
      if (loc2.x - p.loc2.x > 0)
        loc2.x -= loc1.x;
      else
        loc2.x += loc1.x;
      if (loc2.y - p.loc2.y > 0)
        loc2.y -= loc1.y;
      else
        loc2.y += loc1.y;
      fill(255, 0, 0);
      ellipse(loc2.x, loc2.y, bSize, bSize);
    }
    else if (madeByEnemyB)
    {
      loc1.limit(3.5);
      wiggleVel.limit(5);
      if (millis() - wiggleChangeTime - pauseTime >= 100)
      {
        float m = 5;
        float a = loc1.heading2D();
        if (!hasWiggled)
        {
          hasWiggled = true;
          a += HALF_PI;
        }
        if (a == loc1.heading2D() + HALF_PI)
          a -= PI;
        if (a == loc1.heading2D() - HALF_PI)
          a += PI;
        wiggleVel.x = m * cos(a);
        wiggleVel.y = m * sin(a);
        wiggleChangeTime = millis() - pauseTime;
      }
      loc2.add(wiggleVel);
      loc2.add(loc1);
      fill(127.5, 0, 255);
    }
    else if (madeByEnemyC || madeByEnemyD)
    {
      loc1.limit(3.5);
      loc2.add(loc1);
      fill(0, 255, 255);
    }
    ellipse(loc2.x, loc2.y, bSize, bSize);
  }
}


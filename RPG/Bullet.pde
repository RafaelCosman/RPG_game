class Bullet
{
  PVector shootLoc, loc1, loc2;
  int bSize, surviveTime, damage;
  boolean madeByPlayer, madeByEnemyA, madeByEnemyC, madeByEnemyD;

  Bullet(PVector shootLoc, PVector loc1, PVector loc2, int bSize, int surviveTime, int damage, boolean madeByPlayer, boolean madeByEnemyA, boolean madeByEnemyC, boolean madeByEnemyD)
  {
    this.shootLoc = shootLoc;
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.bSize = bSize;
    this.surviveTime = surviveTime;
    this.damage = damage;
    this.madeByPlayer = madeByPlayer;
    this.madeByEnemyA = madeByEnemyA;
    this.madeByEnemyC = madeByEnemyC;
    this.madeByEnemyD = madeByEnemyD;
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
    else if (madeByEnemyC || madeByEnemyD)
    {
      if (dist(p.loc2.x, p.loc2.y, loc2.x, loc2.y) <= p.pSize / 2 + bSize / 2)
        restart = true;
      loc1.limit(3.5);
      loc2.add(loc1);
      fill(0, 255, 255);
    }
    ellipse(loc2.x, loc2.y, bSize, bSize);
  }
}


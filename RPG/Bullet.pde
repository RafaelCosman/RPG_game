abstract class Bullet
{
  PVector vel, loc;
  int bulletSize, damage;
  float speed;
  boolean madeByPlayer, exists, piercing;

  Bullet()
  {
    this(new PVector(), new PVector(), 1, 1, 1, false, true);
  }

  Bullet(PVector vel, PVector loc, int bulletSize, int damage, float speed, boolean madeByPlayer, boolean piercing)
  {
    this.vel = vel;
    this.loc = loc;
    this.bulletSize = bulletSize;
    this.damage = damage;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.exists = true;
    this.piercing = piercing;
  }

  void show()
  {
    ellipse(loc.x, loc.y, bulletSize, bulletSize);
  }

  void run()
  {
    for (Blocker b : blockers)
    {
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) < b.bulletSize / 2 + (bulletSize / 2))
        exists = false;
    }
    if (madeByPlayer)
    {
      for (Enemy e : enemies)
      {
        if (exists && dist(e.loc.x, e.loc.y, loc.x, loc.y) <= e.eSize / 2 + (bulletSize / 2))
        {
          if (!piercing)
            exists = false;
          e.hp -= damage;
        }
        if (e.hp <= 0)
        {
          e.exists = false;
          if (e.partOfQuest)
            p.xp += e.value + 10;
          else
            p.xp += e.value;
        }
      }
    }
    
    loc.add(vel);
  }
}


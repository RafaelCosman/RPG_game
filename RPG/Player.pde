class Player
{
  PVector vel;
  PVector loc;
  int pSize, shootTimer, hp, maxHP, xp, level;

  Player(PVector loc)
  {
    this.vel = new PVector();
    this.loc = loc;
    this.pSize = 15;
    this.shootTimer = 0;
    this.hp = 10;
    this.maxHP = 10;
    this.xp = 0;
    this.level = 1;
  }

  void show()
  {
    fill(0, 255, 0);
    ellipse(loc.x, loc.y, pSize, pSize);
  }

  void run()
  {
    if (keys[0])
      vel.x -= 100;
    if (keys[1])
      vel.x += 100;
    if (keys[2])
      vel.y -= 100;
    if (keys[3])
      vel.y += 100;
    vel.limit(4);
    int testsPassed = 0;
    for (Blocker b : blockers)
    {
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) > b.bSize / 2 + (pSize / 2))
        testsPassed ++;
    }
    if (testsPassed == blockers.size())
      loc.add(vel.x, vel.y, 0);
    vel = new PVector();
    if (loc.x > mapWidth - (pSize / 2))
      loc.x = mapWidth - (pSize / 2);
    else if (loc.x < (pSize / 2))
      loc.x = (pSize / 2);
    if (loc.y > mapHeight - (pSize / 2))
      loc.y = mapHeight - (pSize / 2);
    else if (loc.y < (pSize / 2))
      loc.y = (pSize / 2);
    for (int i = level; i <= level + 1; i ++)
    {
      if (xp >= i)
      {
        xp -= i;
        level ++;
        maxHP ++;
      }
    }
    shootTimer ++;
    if ((mousePressed || autoFireOn))
    {
      if (weapon == 1 && shootTimer >= 250)
      {
        bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));        
        shootTimer = 0;
      }
      if (weapon == 2 && shootTimer >= 150)
      {
        bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));        
        shootTimer = 0;
      }
    }
  }
}


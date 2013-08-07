class Player
{
  PVector vel;
  PVector loc;
  int pSize, shootTime, hp, maxHP, xp, level;
  float speed;

  Player(PVector vel, PVector loc, int pSize, int shootTime, int hp, int maxHP, int xp, int level, float speed)
  {
    this.vel = vel;
    this.loc = loc;
    this.pSize = pSize;
    this.shootTime = shootTime;
    this.hp = hp;
    this.maxHP = maxHP;
    this.xp = xp;
    this.level = level;
    this.speed = speed;
  }

  void show()
  {
    PVector p = new PVector();
    
    int SPEED = 100;
    if (keys[0])
      p.x -= SPEED;
    if (keys[1])
      p.x += SPEED;
    if (keys[2])
      p.y -= SPEED;
    if (keys[3])
      p.y += SPEED;
      
    p.limit(speed);
    int testsPassed = 0;
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc.x + p.x, loc.y + p.y) > b.bulletSize / 2 + (pSize / 2))
        testsPassed ++;
    }
    
    if (testsPassed == blockers.size())
      vel.set(p);
    testsPassed = 0;
    
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) > b.bulletSize / 2 + (pSize / 2))
        testsPassed ++;
    }
    
    if (testsPassed == blockers.size())
      loc.add(vel);
    if (loc.x > mapWidth - (pSize / 2))
      loc.x = mapWidth - (pSize / 2); else if (loc.x < (pSize / 2))
      loc.x = (pSize / 2);
    if (loc.y > mapHeight - (pSize / 2))
      loc.y = mapHeight - (pSize / 2); else if (loc.y < (pSize / 2))
      loc.y = (pSize / 2);
      
    fill(0, 255, 0);
    ellipse(loc.x, loc.y, pSize, pSize);
    
    for (int i = level; i <= level + 1; i ++)
    {
      if (xp >= i)
      {
        xp -= i;
        level ++;
        maxHP ++;
      }
    }
  }
}


class Player
{
  PVector loc1;
  PVector loc2;
  int pSize, shootTime, hp, maxHP, xp, level;

  Player(PVector loc1, PVector loc2, int pSize, int shootTime, int hp, int maxHP, int xp, int level)
  {
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.pSize = pSize;
    this.shootTime = shootTime;
    this.hp = hp;
    this.maxHP = maxHP;
    this.xp = xp;
    this.level = level;
  }

  void show()
  {
    loc1.limit(4);
    if (keys[0] && loc2.x >= 0)
    {
      loc1.x -= 100;
      loc1.limit(4);
      loc2.add(loc1.x, loc1.y, 0);
    }
    if (keys[1] && loc2.x <= height)
    {
      loc1.x += 100;
      loc1.limit(4);
      loc2.add(loc1.x, loc1.y, 0);
    }
    if (keys[2] && loc2.y >= 0)
    {
      loc1.y -= 100;
      loc1.limit(4);
      loc2.add(loc1.x, loc1.y, 0);
    }
    if (keys[3] && loc2.y <= height)
    {
      loc1.y += 100;
      loc1.limit(4);
      loc2.add(loc1.x, loc1.y, 0);
    }
    if (loc2.x > width - (pSize / 2))
      loc2.x = width - (pSize / 2);
    else if (loc2.x < (pSize / 2))
      loc2.x = (pSize / 2);
    if (loc2.y > height - (pSize / 2))
      loc2.y = height - (pSize / 2);
    else if (loc2.y < (pSize / 2))
      loc2.y = (pSize / 2);
    fill(0, 255, 0);
    ellipse(loc2.x, loc2.y, pSize, pSize);
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

abstract class Enemy
{
  PVector vel, loc;
  int eSize, moveTimer, moveTimeDeadline, shootTimer, shootTimeDeadline, hp, value;
  boolean partOfQuest, exists;

  Enemy(PVector loc, int eSize, int shootTimeDeadline, int hp, int value)
  {
    this.vel = new PVector();
    this.loc = loc;
    this.eSize = eSize;
    this.moveTimer = 0;
    this.moveTimeDeadline = moveTimeDeadline;
    this.shootTimeDeadline = shootTimeDeadline;
    this.shootTimer = 0;
    this.hp = hp;
    this.value = value;
    this.partOfQuest = false;
    this.exists = true;
  }

  void show()
  {
    if (partOfQuest)
      stroke(255);
    ellipse(loc.x, loc.y, eSize, eSize);
    noStroke();
  }

  void run()
  {
    moveTimer ++;
    int testsPassed = 0;
    if (moveTimer >= moveTimeDeadline)
    {
      PVector p = PVector.random2D();
      for (int i = 0; i <= blockers.size() - 1; i ++)
      {
        Blocker b = (Blocker) blockers.get(i);
        if (dist(b.loc.x, b.loc.y, loc.x + p.x, loc.y + p.y) > b.bSize / 2 + (eSize / 2))
          testsPassed ++;
      }
      if (testsPassed == blockers.size())
        vel.set(p);
      moveTimer = 0;
      moveTimeDeadline = int(random(25, 125));
    }
    testsPassed = 0;
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) > b.bSize / 2 + (eSize / 2))
        testsPassed ++;
    }
    if (testsPassed == blockers.size())
      loc.add(vel);
    else
      moveTimeDeadline = int(0);
    if (loc.x > mapWidth - (eSize / 2))
      loc.x = mapWidth - (eSize / 2);
    else if (loc.x < (eSize / 2))
      loc.x = (eSize / 2);
    if (loc.y > mapHeight - (eSize / 2))
      loc.y = mapHeight - (eSize / 2);
    else if (loc.y < (eSize / 2))
      loc.y = (eSize / 2);
  }
}


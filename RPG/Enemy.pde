abstract class Enemy
{
  PVector loc1, loc2;
  int eSize, moveTime, moveChange, shootTime, hp, value;
  boolean partOfQuest, exists;

  Enemy(PVector loc1, PVector loc2, int eSize, int moveTime, int moveChange, int shootTime, int hp, int value, boolean partOfQuest, boolean exists)
  {
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.eSize = eSize;
    this.moveTime = moveTime;
    this.moveChange = moveChange;
    this.shootTime = shootTime;
    this.hp = hp;
    this.value = value;
    this.partOfQuest = partOfQuest;
    this.exists = exists;
  }

  void show()
  {
    int testsPassed = 0;
    if (millis() - moveTime - pauseTime >= moveChange)
    {
      PVector p = PVector.random2D();
      for (int i = 0; i <= blockers.size() - 1; i ++)
      {
        Blocker b = (Blocker) blockers.get(i);
        if (dist(b.loc.x, b.loc.y, loc2.x + p.x, loc2.y + p.y) > b.bSize / 2 + (eSize / 2))
          testsPassed ++;
      }
      if (testsPassed == blockers.size())
        loc1.set(p);
      moveTime = millis() - pauseTime;
      moveChange = int(random(250, 1250));
    }
    testsPassed = 0;
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc2.x + loc1.x, loc2.y + loc1.y) > b.bSize / 2 + (eSize / 2))
        testsPassed ++;
    }
    if (testsPassed == blockers.size())
      loc2.add(loc1);
    else
      moveChange = int(0);
    if (loc2.x > width - (eSize / 2))
      loc2.x = width - (eSize / 2);
    else if (loc2.x < (eSize / 2))
      loc2.x = (eSize / 2);
    if (loc2.y > height - (eSize / 2))
      loc2.y = height - (eSize / 2);
    else if (loc2.y < (eSize / 2))
      loc2.y = (eSize / 2);
    if (partOfQuest)
      stroke(255);
    ellipse(loc2.x, loc2.y, eSize, eSize);
    noStroke();
  }
}


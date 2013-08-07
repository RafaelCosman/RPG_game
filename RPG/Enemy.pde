abstract class Enemy
{
  PVector vel, loc;
  int eSize, moveTime, moveChange, shootTime, hp, value;
  boolean partOfQuest, exists;

  Enemy(PVector vel, PVector loc, int eSize, int moveTime, int moveChange, int shootTime, int hp, int value)
  {
    this.vel = vel;
    this.loc = loc;
    this.eSize = eSize;
    this.moveTime = moveTime;
    this.moveChange = moveChange;
    this.shootTime = shootTime;
    this.hp = hp;
    this.value = value;
    this.partOfQuest = false;
    this.exists = true;
  }

  /*
  TODO:Break enemy show method into show and run
  */
  void show()
  {
    int testsPassed = 0;
    if (millis() - moveTime - pauseTime >= moveChange)
    {
      PVector p = PVector.random2D();
      for (int i = 0; i <= blockers.size() - 1; i ++)
      {
        Blocker b = (Blocker) blockers.get(i);
        if (dist(b.loc.x, b.loc.y, loc.x + p.x, loc.y + p.y) > b.bulletSize / 2 + (eSize / 2))
          testsPassed ++;
      }
      if (testsPassed == blockers.size())
        vel.set(p);
      moveTime = millis() - pauseTime;
      moveChange = int(random(250, 1250));
    }
    testsPassed = 0;
    for (int i = 0; i <= blockers.size() - 1; i ++)
    {
      Blocker b = (Blocker) blockers.get(i);
      if (dist(b.loc.x, b.loc.y, loc.x + vel.x, loc.y + vel.y) > b.bulletSize / 2 + (eSize / 2))
        testsPassed ++;
    }
    if (testsPassed == blockers.size())
      loc.add(vel);
    else
      moveChange = int(0);
    if (loc.x > mapWidth - (eSize / 2))
      loc.x = mapWidth - (eSize / 2); else if (loc.x < (eSize / 2))
      loc.x = (eSize / 2);
    if (loc.y > mapHeight - (eSize / 2))
      loc.y = mapHeight - (eSize / 2); else if (loc.y < (eSize / 2))
      loc.y = (eSize / 2);
    if (partOfQuest)
      stroke(255);
      
    ellipse(loc.x, loc.y, eSize, eSize);
    noStroke();
  }
}


class EnemyD extends Enemy
{
  EnemyD(boolean[] hitBy, PVector loc1, PVector loc2, int eSize, int moveTime, int moveChange, int shootTime, int HP, int value, boolean fatal, boolean partOfQuest, boolean exists)
  {
    super(hitBy, loc1, loc2, eSize, moveTime, moveChange, shootTime, HP, value, fatal, partOfQuest, exists);
  }

  void show()
  {
    if (millis() - moveTime - pauseTime >= moveChange)
    {
      loc1 = PVector.random2D();
      moveTime = millis() - pauseTime;
      moveChange = int(random(250, 1250));
    }
    loc2.add(loc1);
    if (loc2.x > width - (eSize / 2))
      loc2.x = width - (eSize / 2);
    else if (loc2.x < (eSize / 2))
      loc2.x = (eSize / 2);
    if (loc2.y > height - (eSize / 2))
      loc2.y = height - (eSize / 2);
    else if (loc2.y < (eSize / 2))
      loc2.y = (eSize / 2);
    if (partOfQuest)
      ;
    fill(0, 0, 255);
    ellipse(loc2.x, loc2.y, eSize, eSize);
    if (millis() - shootTime - pauseTime >= 500 && !pause)
    {
      shotSpread.set(p.loc2.x - loc2.x, p.loc2.y - loc2.y, 0);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, -1, 2, 275, 4, false, false, false, true, true, true));
      float m = shotSpread.mag();
      float a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, -1, 2, 275, 4, false, false, false, true, true, true));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, -1, 2, 275, 4, false, false, false, true, true, true));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= 1.5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, -1, 2, 275, 4, false, false, false, true, true, true));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, -1, 2, 275, 4, false, false, false, true, true, true));
      shootTime = millis() - pauseTime;
    }
  }
}

class EnemyA extends Enemy
{
  EnemyA(boolean[] hitBy, PVector loc1, PVector loc2, int eSize, int moveTime, int moveChange, int shootTime, int HP, int value, boolean fatal, boolean partOfQuest, boolean exists)
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
    fill(255, 255, 0);
    ellipse(loc2.x, loc2.y, eSize, eSize);
    if (millis() - shootTime - pauseTime >= 500 && !pause)
    {
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(0, 0), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, 5000, 4, -1, 4, false, true, false, false, true, false));
      shootTime = millis() - pauseTime;
    }
  }
}

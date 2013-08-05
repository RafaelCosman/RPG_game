class EnemyD extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  EnemyD(PVector loc1, PVector loc2, int moveTime, int moveChange, int shootTime)
  {
    super(loc1, loc2, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE, PART_OF_QUEST, EXISTS);
  }

  void show()
  {
    fill(0, 0, 255);
    super.show();
    if (millis() - shootTime - pauseTime >= 1500)
    {
      shotSpread.set(p.loc2.x - loc2.x, p.loc2.y - loc2.y, 0);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 2, 275, -1, -1, 4.0, false, false, false, false, true, true, true, false));
      float m = shotSpread.mag();
      float a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 2, 275, -1, -1, 4.0, false, false, false, false, true, true, true, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 2, 275, -1, -1, 4.0, false, false, false, false, true, true, true, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= 1.5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 2, 275, -1, -1, 4.0, false, false, false, false, true, true, true, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(shotSpread.x, shotSpread.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 2, 275, -1, -1, 4.0, false, false, false, false, true, true, true, false));
      shootTime = millis() - pauseTime;
    }
  }
}


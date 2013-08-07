class EnemyD extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  EnemyD(PVector vel, PVector loc, int moveTime, int moveChange, int shootTime)
  {
    super(vel, loc, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE, PART_OF_QUEST, EXISTS);
  }

  void show()
  {
    fill(0, 0, 255);
    super.show();
    if (millis() - shootTime - pauseTime >= 1500)
    {
      shotSpread.set(p.loc.x - loc.x, p.loc.y - loc.y, 0);
      bullets.add(new StraightBullet(new PVector(), new PVector(loc.x, loc.y), 5, 4, 275, 4.5, false, false));
      float m = shotSpread.mag();
      float a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new StraightBullet(new PVector(), new PVector(loc.x, loc.y), 5, 4, 275, 4.5, false, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new StraightBullet(new PVector(), new PVector(loc.x, loc.y), 5, 4, 275, 4.5, false, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= 1.5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new StraightBullet(new PVector(), new PVector(loc.x, loc.y), 5, 4, 275, 4.5, false, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new StraightBullet(new PVector(), new PVector(loc.x, loc.y), 5, 4, 275, 4.5, false, false));
      shootTime = millis() - pauseTime;
    }
  }
}


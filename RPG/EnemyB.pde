class EnemyB extends Enemy
{
  final static int E_SIZE = 25;
  final static int SHOOT_TIME_DEADLINE = 100;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  int moveTimeDeadline;

  EnemyB(PVector loc, int moveTimeDeadline)
  {
    super(loc, E_SIZE, SHOOT_TIME_DEADLINE, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(0, 255, 255);
    super.show();
    shootTimer ++;
    shotSpread.set(p.loc.x - loc.x, p.loc.y - loc.y, 0);
    float m = shotSpread.mag();
    if (shootTimer >= shootTimeDeadline)
    {
      //for (float a = shotSpread.heading2D(); a <= shotSpread.heading2D() + TWO_PI)
      //{
      bullets.add(new BulletWiggle(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 3, 300, 5.0, PI, false, false));
      float a = shotSpread.heading2D();
      a += .75;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      //}
      bullets.add(new BulletWiggle(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 3, 300, 5.0, PI, false, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= 1.5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new BulletWiggle(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 3, 300, 5.0, PI, false, false));
      shootTimer = 0;
    }
  }
}


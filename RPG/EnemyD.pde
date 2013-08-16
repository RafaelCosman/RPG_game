class EnemyD extends Enemy
{
  final static int E_SIZE = 25;
  final static int SHOOT_TIME_DEADLINE = 125;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  int moveTimeDeadline;

  EnemyD(PVector loc, int moveTimeDeadline)
  {
    super(loc, E_SIZE, SHOOT_TIME_DEADLINE, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(0, 0, 255);
    super.show();
    shootTimer ++;
    if (shootTimer >= shootTimeDeadline)
    {
      shotSpread.set(p.loc.x - loc.x, p.loc.y - loc.y, 0);
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));
      float m = shotSpread.mag();
      float a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a += .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));      
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= 1.5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));      
      m = shotSpread.mag();
      a = shotSpread.heading2D();
      a -= .5;
      shotSpread.x = m * cos(a);
      shotSpread.y = m * sin(a);
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(shotSpread.x, shotSpread.y), 5, 4, 300, 3.75, false, false));      
      shootTimer = 0;
    }
  }
}


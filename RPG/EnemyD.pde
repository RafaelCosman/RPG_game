class EnemyD extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;

  EnemyD(PVector vel, PVector loc, int moveTime, int moveChange, int shootTime)
  {
    super(vel, loc, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(0, 0, 255);
    super.show();
    if (millis() - shootTime - pauseTime >= 1500)
      makeBullet();
  }

  void makeBullet()
  {
    bullets.add(new StraightBullet(new PVector(), copy(loc), 5, 4, 275, 4.5, false, false));
  }
}


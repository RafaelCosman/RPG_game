class EnemyA extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 3;

  EnemyA(PVector vel, PVector loc, int moveTime, int moveChange, int shootTime)
  {
    super(vel, loc, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(255, 255, 0);
    super.show();
    
    if (millis() - shootTime - pauseTime >= 1500)
    {
      bullets.add(new FollowBullet(new PVector(), copy(loc), 5, 2, 4.75, millis() - pauseTime, 5000, false, false));
      shootTime = millis() - pauseTime;
    }
  }
}


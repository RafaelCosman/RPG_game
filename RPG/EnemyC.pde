class EnemyC extends Enemy
{
  final static int E_SIZE = 25;
  final static int SHOOT_TIME_DEADLINE = 80;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 3;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  int moveTimeDeadline;

  EnemyC(PVector loc, int moveTimeDeadline)
  {
    super(loc, E_SIZE, SHOOT_TIME_DEADLINE, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(255, 0, 255);
    super.show();
    shootTimer ++;
    if (shootTimer >= shootTimeDeadline)
    {
      bullets.add(new BulletStraight(new PVector(loc.x, loc.y), new PVector(loc.x, loc.y), 5, 4, 300, 4.5, false, false));
      shootTimer = 0;
    }
  }
}


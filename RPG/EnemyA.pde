class EnemyA extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 3;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  EnemyA(PVector loc1, PVector loc2, int moveTime, int moveChange, int shootTime)
  {
    super(loc1, loc2, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE, PART_OF_QUEST, EXISTS);
  }

  void show()
  {
    fill(255, 255, 0);
    super.show();
    if (millis() - shootTime - pauseTime >= 500 && !pause)
    {
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(0, 0), new PVector(loc2.x, loc2.y), 5, millis() - pauseTime, 5000, 4, -1, 4, false, true, false, false, true, false));
      shootTime = millis() - pauseTime;
    }
  }
}


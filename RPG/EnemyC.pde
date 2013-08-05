class EnemyC extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 3;
  final static boolean PART_OF_QUEST = false;
  final static boolean EXISTS = true;

  EnemyC(PVector loc1, PVector loc2, int moveTime, int moveChange, int shootTime)
  {
    super(loc1, loc2, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE, PART_OF_QUEST, EXISTS);
  }

  void show()
  {
    fill(255, 0, 255);
    super.show();
    if (millis() - shootTime - pauseTime >= 1350)
    {
      bullets.add(new Bullet(new PVector(loc2.x, loc2.y), new PVector(p.loc2.x - loc2.x, p.loc2.y - loc2.y), new PVector(loc2.x, loc2.y), new PVector(), 5, millis() - pauseTime, -1, 3, 300, -1, -1, 4.5, false, false, false, true, false, true, true, false));
      shootTime = millis() - pauseTime;
    }
  }
}


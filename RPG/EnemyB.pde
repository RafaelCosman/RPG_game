class EnemyB extends Enemy
{
  final static int E_SIZE = 25;
  final static int INITIAL_HP = 15;
  final static int INITIAL_XP_VALUE = 6;

  EnemyB(PVector vel, PVector loc, int moveTime, int moveChange, int shootTime)
  {
    super(vel, loc, E_SIZE, moveTime, moveChange, shootTime, INITIAL_HP, INITIAL_XP_VALUE);
  }

  void show()
  {
    fill(0, 255, 255);
    super.show();
    if (millis() - shootTime - pauseTime >= 1750)
    {
      shotSpread.set(p.loc.x - loc.x, p.loc.y - loc.y, 0);
      float m = shotSpread.mag();
      float a = shotSpread.heading2D();
      fireGivenHeadingAndMag(a, m);
      a += .75;
      fireGivenHeadingAndMag(a, m);
      a -= 1.5;
      fireGivenHeadingAndMag(a, m);
      shootTime = millis() - pauseTime;
    }
  }

  void fireGivenHeadingAndMag(float a, float m) 
  {
    PVector vel = new PVector(m * cos(a), m * sin(a));
    bullets.add(new WigglyBullet(new PVector(), vel, copy(loc), 5, 2, 300, 10, 100, PI, 4.5, false, true, true));
  }
}


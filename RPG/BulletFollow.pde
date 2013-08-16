class BulletFollow extends Bullet
{
  PVector loc;
  int bSize, surviveTimeCurrent, surviveTimeDeadline, damage;
  float speed;
  boolean madeByPlayer, piercing;

  BulletFollow(PVector loc, int bSize, int surviveTimeDeadline, int damage, float speed, boolean madeByPlayer, boolean piercing)
  {
    super(loc, bSize, damage, speed, madeByPlayer, piercing);
    this.bSize = bSize;
    this.surviveTimeCurrent = 0;
    this.surviveTimeDeadline = surviveTimeDeadline;
    this.damage = damage;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.piercing = piercing;
  }

  void show()
  {
    if (madeByPlayer)
      fill(PLAYER_BULLET_COLOR);
    else
      fill(127.5, 0, 255);
    super.show();
  }

  void run()
  {
    vel.set(PVector.sub(loc, p.loc));
    vel.limit(speed);
    if (surviveTimeCurrent >= surviveTimeDeadline)
      exists = false;
  }
}


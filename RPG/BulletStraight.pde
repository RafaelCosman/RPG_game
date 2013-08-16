class BulletStraight extends Bullet
{
  PVector shootLoc, loc;
  int bSize, surviveTimeCurrent, surviveTimeDeadline, damage, range;
  float speed;
  boolean madeByPlayer, piercing;

  BulletStraight(PVector shootLoc, PVector loc, int bSize, int damage, int range, float speed, boolean madeByPlayer, boolean piercing)
  {
    super(loc, bSize, damage, speed, madeByPlayer, piercing);
    this.shootLoc = shootLoc;
    this.bSize = bSize;
    this.damage = damage;
    this.range = range;
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
    vel.limit(speed);
    loc.add(vel);
    if (dist(loc.x, loc.y, shootLoc.x, shootLoc.y) >= range)
      exists = false;
  }
}


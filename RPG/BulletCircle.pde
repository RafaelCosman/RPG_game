class BulletCircle extends Bullet
{
  PVector shootLoc, loc;
  int bSize, damage, range;
  float speed, rotateAmount;
  boolean madeByPlayer, piercing;

  BulletCircle(PVector shootLoc, PVector loc, int bSize, int damage, int range, float speed, float rotateAmount, boolean madeByPlayer, boolean piercing)
  {
    super(loc, bSize, damage, speed, madeByPlayer, piercing);
    this.shootLoc = shootLoc;
    this.bSize = bSize;
    this.damage = damage;
    this.range = range;
    this.speed = speed;
    this.rotateAmount = rotateAmount;
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
    if (dist(loc.x, loc.y, shootLoc.x, shootLoc.y) >= range)
      exists = false;
  }
}


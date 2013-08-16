class BulletWiggle extends Bullet
{
  PVector shootLoc, loc;
  int bSize, damage, range, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline;
  float speed, rotateAmount;
  boolean madeByPlayer, piercing, hasWiggled;

  BulletWiggle(PVector shootLoc, PVector loc, int bSize, int damage, int range, float speed, float rotateAmount, boolean madeByPlayer, boolean piercing)
  {
    super(loc, bSize, damage, speed, madeByPlayer, piercing);
    this.shootLoc = shootLoc;
    this.wiggleVel = wiggleVel;
    this.bSize = bSize;
    this.damage = damage;
    this.range = range;
    this.wiggleAmount = wiggleAmount;
    this.wiggleChangeTimer = 0;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.piercing = piercing;
    this.hasWiggled = false;
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
    wiggleVel.limit(wiggleAmount);
    if (wiggleChangeTimer >= 100)
    {
      float m = 5;
      float a = vel.heading2D();
      if (!hasWiggled)
      {
        hasWiggled = true;
        a += rotateAmount / 2;
      }
      if (a == vel.heading2D() + rotateAmount)
        a -= rotateAmount;
      if (a == vel.heading2D() - rotateAmount / 2)
        a += rotateAmount;
      wiggleVel.x = m * cos(a);
      wiggleVel.y = m * sin(a);
      wiggleChangeTimer = 0;
    }
    wiggleChangeTimer ++;
    loc.add(wiggleVel);
    loc.add(vel);
    if (dist(loc.x, loc.y, shootLoc.x, shootLoc.y) >= range)
      exists = false;
  }
}


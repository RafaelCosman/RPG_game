abstract class Bullet
{
  PVector shootLoc, vel, loc, wiggleVel;
  int bSize, surviveTimeCurrent, surviveTimeDeadline, damage, range, wiggleAmount, wiggleChangeTimer, wiggleChangeDeadline;
  float speed;
  boolean madeByPlayer, exists, piercing, hasWiggled;

  Bullet(PVector loc, int bSize, int damage, float speed, boolean madeByPlayer, boolean piercing)
  {
    this.shootLoc = shootLoc;
    this.vel = new PVector();
    this.loc = loc;
    this.bSize = bSize;
    this.damage = damage;
    this.range = range;
    this.speed = speed;
    this.madeByPlayer = madeByPlayer;
    this.exists = true;
    this.piercing = piercing;
    this.hasWiggled = false;
  }

  void show()
  {
    ellipse(loc.x, loc.y, bSize, bSize);
  }

  void run()
  {
  }
}


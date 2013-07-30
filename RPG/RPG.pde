Player p;
PVector shotSpread;
ArrayList enemiesA;
ArrayList enemiesC;
ArrayList enemiesD;
ArrayList bullets;
ArrayList allBullets;
PImage steelShortswordReal;
PImage steelShortswordMask;
PImage steelShortswordReal2;
PImage steelShortswordMask2;
PFont font = createFont("Arial", 32);
boolean[] keys = new boolean[4];
boolean restart;
boolean pause;
boolean autoFireOn = true;
boolean b;
boolean bulletExists;
final int maxWeapons = 2;
int pauseTime;
int pauseStart;
int weapon = 1;
int eACreate;
int eBCreate;
int eCCreate;
int eDCreate;
int questTime;
int x3;
int y3;
int px3;
int py3;
PVector pv = new PVector(mouseX, mouseY);
float eACreateModifier;
float eBCreateModifier;
float eCCreateModifier;
float eDCreateModifier;

void setup()
{
  size(600, 600, P3D);
  smooth();
  noStroke();
  rectMode(CENTER);
  shotSpread = new PVector();
  steelShortswordReal = loadImage("Steel Shortsword (Real).png");
  steelShortswordMask = loadImage("Steel Shortsword (Mask).jpg");
  steelShortswordReal2 = loadImage("Steel Shortsword (Real).png");
  steelShortswordMask2 = loadImage("Steel Shortsword (Mask).jpg");
  b = false;
  textFont(font);
  restart();
}

void restart()
{
  restart = false;
  pause = false;
  eACreateModifier = 1;
  eBCreateModifier = 1;
  eCCreateModifier = 1;
  eDCreateModifier = 1;
  enemiesA = new ArrayList();
  enemiesC = new ArrayList();
  enemiesD = new ArrayList();
  bullets = new ArrayList();
  allBullets = new ArrayList();
  p = new Player(new PVector(width / 2, height / 2), new PVector(width / 2, height / 2), 15, millis() - pauseTime, 10000000, 10, 0, 1);
  x3 = 100;
  y3 = 100;
  px3 = 100;
  py3 = 100;
  pauseTime = 0;
  pauseStart = 0;
  eACreate = millis() - pauseTime;
  eBCreate = millis() - pauseTime;
  eCCreate = millis() - pauseTime;
  eDCreate = millis() - pauseTime;
  questTime = millis() - pauseTime;
}

void draw()
{
  pv.set(mouseX, mouseY, 0);
  if (!restart)
  {
    if (!pause)
    {
      background(127.5);
      fill(127.5);
      rect(width / 2, height / 2, width, height);
      p.show();
      camera(p.loc2.x, p.loc2.y, (height / 2) / tan(PI * 30 / 180), p.loc2.x, p.loc2.y, 0, 0, 1, 0);
      tint(255, 0);
      image(steelShortswordMask, x3, y3);
      image(steelShortswordMask2, pv.x, pv.y);
      noTint();
      image(steelShortswordReal, x3, y3);
      image(steelShortswordReal2, pv.x, pv.y);
      boolean collision = pv.x < x3 + steelShortswordMask2.width && pv.x + steelShortswordMask.width > x3 && pv.y < y3 + steelShortswordMask2.height && pv.y + steelShortswordMask.height > y3;
      if (collision)
      {
        x3 = int(pv.x);
        y3 = int(pv.y);
        tint(255, 0);
        for (int x = x3; x <= x3 + steelShortswordMask.width; x ++)
        {
          for (int y = y3; y <= y3 + steelShortswordMask.height; y ++)
          {
            loadPixels();
            image(steelShortswordMask, x3, y3);
            color c1 = get(x, y);
            image(steelShortswordMask2, pv.x, pv.y);
            color c2 = get(x, y);
            updatePixels();
            float f1 = c1 >> 16 & 0xFF;
            float f2 = c2 >> 16 & 0xFF;
            if (f1 == 0 && f2 == 0)
            {
              println(f2);
              restart();
            }
          }
        }
        noTint();
      }
      if (millis() - questTime - pauseTime >= 5000)
      {
        questTime = millis() - pauseTime;
        int totalEnemies = enemiesA.size() - 1 + (enemiesC.size() - 1) + (enemiesD.size() - 1);
        int randomEnemy = int(random(totalEnemies + 1));
        if (randomEnemy <= enemiesA.size() - 1)
        {
          EnemyA e = (EnemyA) enemiesA.get(int(random(enemiesA.size() - 1)));
          e.partOfQuest = true;
        }
        else if (randomEnemy <= enemiesA.size() - 1 + (enemiesC.size() - 1))
        {
          EnemyA e = (EnemyA) enemiesA.get(int(random(enemiesA.size() - 1)));
          e.partOfQuest = true;
        }
        else
        {
          EnemyA e = (EnemyA) enemiesA.get(int(random(enemiesA.size() - 1)));
          e.partOfQuest = true;
        }
      }
    }
    else
      pauseTime = millis() - pauseStart;
    fill(0);
    textAlign(LEFT, TOP);
    text(p.HP, p.loc2.x - (width / 2), p.loc2.y - (height / 2));
    textAlign(RIGHT, TOP);
    text(p.XP, p.loc2.x + (width / 2), p.loc2.y - (height / 2));
    if (millis() - eACreate - pauseTime >= 1500 * eACreateModifier && !pause)
    {
      eACreate = millis() - pauseTime;
      eACreateModifier *= .975;
      enemiesA.add(new EnemyA(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 15, 3, false, false));
      EnemyA e = (EnemyA) enemiesA.get(enemiesA.size() - 1);
      while (dist (e.loc2.x, e.loc2.y, p.loc2.x, p.loc2.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
        e.loc2.set(random(width), random(height), 0);
      e.fatal = true;
    }
    for (int i = 0; i <= enemiesA.size() - 1; i ++)
    {
      if (!pause)
      {
        EnemyA e = (EnemyA) enemiesA.get(i);
        e.show();
      }
    }
    if (millis() - eCCreate - pauseTime >= 1500 * eCCreateModifier && !pause)
    {
      eCCreate = millis() - pauseTime;
      eCCreateModifier *= .975;
      enemiesC.add(new EnemyC(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 15, 3, false, false));
      EnemyC e = (EnemyC) enemiesC.get(enemiesC.size() - 1);
      while (dist (e.loc2.x, e.loc2.y, p.loc2.x, p.loc2.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
        e.loc2.set(random(width), random(height), 0);
      e.fatal = true;
    }
    for (int i = 0; i <= enemiesC.size() - 1; i ++)
    {
      if (!pause)
      {
        EnemyC e = (EnemyC) enemiesC.get(i);
        e.show();
      }
    }
    if (millis() - eDCreate - pauseTime >= 2750 * eDCreateModifier && !pause)
    {
      eDCreate = millis() - pauseTime;
      eDCreateModifier *= .975;
      enemiesD.add(new EnemyD(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 25, 11, false, false));
      EnemyD e = (EnemyD) enemiesD.get(enemiesD.size() - 1);
      while (dist (e.loc2.x, e.loc2.y, p.loc2.x, p.loc2.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
        e.loc2.set(random(width), random(height), 0);
      e.fatal = true;
    }
    for (int i = 0; i <= enemiesD.size() - 1; i ++)
    {
      if (!pause)
      {
        EnemyD e = (EnemyD) enemiesD.get(i);
        e.show();
      }
    }
    if ((mousePressed || autoFireOn))
    {
      if (weapon == 1 && millis() - p.shootTime - pauseTime >= 250)
      {
        p.shootTime = millis() - pauseTime;
        bullets.add(new Bullet(new PVector(p.loc2.x, p.loc2.y), new PVector(mouseX - (width / 2), mouseY - (height / 2)), new PVector(p.loc2.x, p.loc2.y), 5, -1, -1, 6, 250, 3.5, true, false, false, false));
      }
      if (weapon == 2 && millis() - p.shootTime - pauseTime >= 150)
      {
        p.shootTime = millis() - pauseTime;
        bullets.add(new Bullet(new PVector(p.loc2.x, p.loc2.y), new PVector(mouseX - (width / 2), mouseY - (height / 2)), new PVector(p.loc2.x, p.loc2.y), 5, -1, -1, 4, 225, 3.5, true, false, false, false));
      }
    }
    allBullets = bullets;
    for (int i = 0; i <= allBullets.size() - 1; i ++)
    {
      Bullet b = (Bullet) bullets.get(i);
      b.show();
      bulletExists = true;
      if (b.madeByPlayer)
      {
        bulletBehavior(enemiesA, i);
        if (bulletExists)
          bulletBehavior(enemiesC, i);
        if (bulletExists)
          bulletBehavior(enemiesD, i);
      }
      else if (bulletExists && dist(p.loc2.x, p.loc2.y, b.loc2.x, b.loc2.y) <= p.pSize / 2 + b.bSize / 2)
      {
        bullets.remove(i);
        bulletExists = false;
        p.HP -= b.damage;
        if (p.HP <= 0)
          restart = true;
      }
      if (bulletExists && ((dist(b.loc2.x, b.loc2.y, b.shootLoc.x, b.shootLoc.y) >= b.range && b.range != -1) || (millis() - b.surviveTimeCurrent - pauseTime >= b.surviveTimeDeadline && b.surviveTimeDeadline != -1)))
        allBullets.remove(i);
    }
  }
  x3 = px3;
  y3 = py3;
}

void keyPressed()
{
  if (key == 'r')
    restart();
  if (key == 'p')
  {
    pause = !pause;
    pauseStart = millis() - pauseTime;
  }
  if (key == 'f')
    autoFireOn = !autoFireOn;
  if (key == 'i')
  {
    weapon ++;
    if (weapon > maxWeapons)
      weapon = 1;
  }
  if (key == 'h')
  {
    if (p.HP >= p.maxHP)
      p.HP = p.maxHP;
    else
      p.HP ++;
  }
  if (key == 'x')
    p.XP += 1;
  if (key == 'a')
    keys[0] = true;
  if (key == 'd')
    keys[1] = true;
  if (key == 'w')
    keys[2] = true;
  if (key == 's')
    keys[3] = true;
}

void keyReleased()
{
  if (key == 'a')
    keys[0] = false;
  if (key == 'd')
    keys[1] = false;
  if (key == 'w')
    keys[2] = false;
  if (key == 's')
    keys[3] = false;
}

void bulletBehavior(ArrayList enemyList, int i)
{
  for (int i2 = 0; i2 <= enemyList.size() - 1; i2 ++)
  {
    Bullet b = (Bullet) bullets.get(i);
    Enemy e = (Enemy) enemyList.get(i2);
    if (dist(e.loc2.x, e.loc2.y, b.loc2.x, b.loc2.y) <= e.eSize / 2 + (b.bSize / 2) && e.fatal)
    {
      if (!e.hitBy[i])
      {
        if (weapon == 1)
        {
          bullets.remove(i);
          bulletExists = false;
          e.HP -= b.damage;
        }
        else if (weapon == 2)
        {
          e.HP -= b.damage;
        }
      }
      e.hitBy[i] = true;
    }
    if (e.HP <= 0)
    {
      enemyList.remove(i2);
      if (e.partOfQuest)
        p.XP += e.value + 10;
      else
        p.XP += e.value;
    }
  }
}

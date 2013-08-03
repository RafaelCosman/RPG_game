/// Comments beginning with a triple slash are notes added by Ben.
/// They will often begin "/// Pn TODO: ..." where Pn will
/// be a priority score approximately as follows:
///   P0: major bug
///   P1: minor bug or major style issue
///   P2: medium style issue or performance issue
///   P3: minor style issue
///   P4: very minor suggestion (in fact I give you two additional
///       options for resoving P4s: you can ask me to do it for you,
///       or you can even just delete it without doing anything (i.e.
///       if you disagree with my suggestion).
/// You should remove these TODOs as you complete them. THERE IS *NO*
/// HURRY FOR YOU TO DEAL WITH THEM, but remember that I will in
/// general be teaching you things that will make your code easier
/// to use and read, so working on these will both be good experience
/// for your future as a programmer and also for me being able to fix
/// your bugs faster right now. If I teach you something like a
/// style guideline in one of these notes, please apply that to all
/// similar cases in your code and not just the labeled line.

Player p;
PVector shotSpread;
ArrayList enemiesA;
ArrayList enemiesC;
ArrayList enemiesD;
ArrayList<Bullet> bullets;
color FOREGROUND = color(0);
color BACKGROUND = color(255);
PImage img1;
PImage mask1;
PImage img2;
PImage mask2;
/// P3 TODO: By convention, global variables that are set once up here and never changed should be labeled "final" and should have their name in ALL_CAPS (with underscores separating words if there are more than one). 
/// If you follow this convention, then a reader knows that whenever they see an ALL_CAPS variable, if they want to figure out the value of the variable they can just look at the top and not have to worry about 
/// scanning your whole code for places it may have changed. Note that in order for this convention to be useful you need to use it consistently, so for example the "HP" field in Enemy should be "hp" instead because
/// it's *not* a final constant.
PFont font = createFont("Arial", 32);
boolean[] keys = new boolean[4];
boolean restart;
boolean pause;
boolean autoFireOn = true;
final int maxWeapons = 2;
int pauseTime;
int pauseStart;
int weapon = 1;
int eACreate;
/// P3 TODO: Remove totally unused variables; they pointlessly clutters your code.
int eBCreate;
int eCCreate;
int eDCreate;
int questTime;
PVector pv = new PVector(mouseX, mouseY);
float eACreateModifier;
float eBCreateModifier;
float eCCreateModifier;
float eDCreateModifier;

/// P4 TODO: Modern code style recommends not giving opening braces a line to themselves (see http://processing.org/examples/widthheight.html for an example), mostly just because people think that
/// this way you can fit more code on your screen without making it any less readable.
void setup()
{
  size(550, 550, P3D);
  smooth();
  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  shotSpread = new PVector();
  img1 = loadImage("Steel Shortsword (Real).png");
  mask1 = loadImage("Steel Shortsword (Mask).jpg");
  img2 = loadImage("Steel Shortsword (Real).png");
  mask2 = loadImage("Steel Shortsword (Mask).jpg");
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
  enemiesD = new ArrayList<Bullet>();
  bullets = new ArrayList<Bullet>();
  /// P1 TODO: Think about the value and uses of pauseTime over the rest of this method. Are you sure you're doing what you want to be doing?
  p = new Player(new PVector(width / 2, height / 2), new PVector(width / 2, height / 2), 15, millis() - pauseTime, 10000000, 10, 0, 1);
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
  /// P2 TODO: Really long blocks of code should be avoided because the logic is less clear to the reader - I try to wrap my mind around what is supposed to happen if restart is false and I can't because
  /// it's literally everything else in draw. (a block is a set of lines between braces, in this case the ... of the "if (!restart) {...}")
  /// Can you think of a way of accomplishing the same effect without wrapping so much code into this if statement? (Hint: you can exit a method with the "return" statement.)
  if (!restart)
  {
    if (!pause)
    {
      background(127.5);
      fill(127.5);
      rect(width / 2, height / 2, width, height);
      p.show();
      camera(p.loc2.x, p.loc2.y, (height / 2) / tan(PI * 30 / 180), p.loc2.x, p.loc2.y, 0, 0, 1, 0);
      PVector loc1 = new PVector(100, 100);
      PVector loc2 = new PVector(mouseX, mouseY);
      image(img1, loc1);
      image(img2, loc2);
      PVector offset = PVector.sub(loc2, loc1);
      println(collisionDetection(offset));
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
      fill(0);
      textAlign(LEFT, TOP);
      text(p.HP, p.loc2.x - (width / 2), p.loc2.y - (height / 2));
      textAlign(RIGHT, TOP);
      text(p.XP, p.loc2.x + (width / 2), p.loc2.y - (height / 2));
      if (millis() - eACreate - pauseTime >= 1500 * eACreateModifier && !pause)
      {
        eACreate = millis() - pauseTime;
        eACreateModifier *= .975;
        enemiesA.add(new EnemyA(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 15, 3, false, false, true));
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
          if (e.exists)
            e.show();
        }
      }
      if (millis() - eCCreate - pauseTime >= 1500 * eCCreateModifier && !pause)
      {
        eCCreate = millis() - pauseTime;
        eCCreateModifier *= .975;
        enemiesC.add(new EnemyC(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 15, 3, false, false, true));
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
          if (e.exists)
            e.show();
        }
      }
      if (millis() - eDCreate - pauseTime >= 2750 * eDCreateModifier && !pause)
      {
        eDCreate = millis() - pauseTime;
        eDCreateModifier *= .975;
        enemiesD.add(new EnemyD(new boolean[999], new PVector(0, 0), new PVector(random(width), random(height)), 25, millis() - pauseTime, int(random(250, 1000)), millis() - pauseTime, 25, 11, false, false, true));
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
          if (e.exists)
            e.show();
        }
      }
      if ((mousePressed || autoFireOn))
      {
        if (weapon == 1 && millis() - p.shootTime - pauseTime >= 250)
        {
          bullets.add(new Bullet(new PVector(p.loc2.x, p.loc2.y), new PVector(mouseX - (width / 2), mouseY - (height / 2)), new PVector(p.loc2.x, p.loc2.y), 5, -1, -1, 6, 250, 3.5, true, false, false, false, true, false));
          p.shootTime = millis() - pauseTime;
        }
        if (weapon == 2 && millis() - p.shootTime - pauseTime >= 150)
        {
          bullets.add(new Bullet(new PVector(p.loc2.x, p.loc2.y), new PVector(mouseX - (width / 2), mouseY - (height / 2)), new PVector(p.loc2.x, p.loc2.y), 5, -1, -1, 4, 225, 3.5, true, false, false, false, true, true));
          p.shootTime = millis() - pauseTime;
        }
      }
      for (Bullet b : bullets)
      {
        if (b.exists)
        {
          if (b.madeByPlayer)
          {
            bulletBehavior(enemiesA, b);
            bulletBehavior(enemiesC, b);
            bulletBehavior(enemiesD, b);
          }
          else if (dist(p.loc2.x, p.loc2.y, b.loc2.x, b.loc2.y) <= p.pSize / 2 + b.bSize / 2)
          {
            b.exists = false;
            p.HP -= b.damage;
            if (p.HP <= 0)
              restart = true;
          }
          if ((dist(b.loc2.x, b.loc2.y, b.shootLoc.x, b.shootLoc.y) >= b.range && b.range != -1) || (millis() - b.surviveTimeCurrent - pauseTime >= b.surviveTimeDeadline && b.surviveTimeDeadline != -1))
            b.exists = false;
          b.show();
        }
      }
      for (int i = 0; i <= enemiesA.size() - 1; i ++)
      {
        Enemy e = (Enemy) enemiesA.get(i);
        if (!e.exists)
        {
          enemiesA.remove(i);
          continue;
        }
      }
      for (int i = 0; i <= enemiesC.size() - 1; i ++)
      {
        Enemy e = (Enemy) enemiesC.get(i);
        if (!e.exists)
        {
          enemiesC.remove(i);
          continue;
        }
      }
      for (int i = 0; i <= enemiesD.size() - 1; i ++)
      {
        Enemy e = (Enemy) enemiesD.get(i);
        if (!e.exists)
        {
          enemiesD.remove(i);
          continue;
        }
      }
    }
    else
      pauseTime = millis() - pauseStart;
  }
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

void bulletBehavior(ArrayList<Enemy> enemyList, Bullet b)
{
  for (Enemy e : enemyList)
  {
    if (b.exists && dist(e.loc2.x, e.loc2.y, b.loc2.x, b.loc2.y) <= e.eSize / 2 + (b.bSize / 2) && e.fatal)
    {
      if (!b.piercing)
        b.exists = false;
      e.HP -= b.damage;
    }
    if (e.HP <= 0)
    {
      e.exists = false;
      if (e.partOfQuest)
        p.XP += e.value + 10;
      else
        p.XP += e.value;
    }
  }
}

boolean collisionDetection(PVector offset)
{
  for (int x = 0; x < mask1.width; x++)
    for (int y = 0; y < mask1.height; y++)
      if (mask1.get(x, y) == FOREGROUND && mask2.get(int(x + offset.x), int(y + offset.y)) == FOREGROUND)
        return true;

  return false;
}


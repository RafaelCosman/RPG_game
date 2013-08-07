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
/// general be teaching you things that will make your code easiear
/// to use and read, so working on these will both be good experience
/// for your future as a programmer and also for me being able to fix
/// your bugs faster right now. If I teach you something like a
/// style guideline in one of these notes, please apply that to all
/// similar cases in your code and not just the labeled line.

Player p;
PVector shotSpread;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Blocker> blockers;
color FOREGROUND = color(0);
color BACKGROUND = color(255);
PImage img1;
PImage mask1;
PImage img2;
PImage mask2;
/// P3 TODO: By convention, global variables that are set once up here and never changed should be labeled "final" and should have their name in ALL_CAPS (with underscores separating words if there are more than one). 
/// If you follow this convention, then a reader knows that whenever they see an ALL_CAPS variable, if they want to figure out the value of the variable they can just look at the top and not have to worry about 
/// scanning your whole code for places it may have changed. Note that in order for this convention to be useful you need to use it consistently, so I changed the "HP" (and "XP") fields in Enemy and Player to "hp" 
/// instead because they're *not* final constant.
final int fontSize = 32;
PFont font = createFont("Arial", fontSize);
boolean[] keys = new boolean[4];
boolean restart;
boolean isPaused;
boolean autoFireOn = true;
final int maxWeapons = 2;
int mapWidth;
int mapHeight;
int maxEnemies = 100;
int pauseTime;
int pauseStart;
int weapon = 1;
int questTime;
PVector pv = new PVector(mouseX, mouseY);

/// P4 TODO: Modern code style recommends not giving opening braces a line to themselves (see http://processing.org/examples/widthheight.html for an example), mostly just because people think that
/// this way you can fit more code on your screen without making it any less readable.
void setup()
{
  size(displayWidth, displayHeight, P3D);
  smooth();
  noStroke();
  strokeWeight(3);
  rectMode(CENTER);
  imageMode(CENTER);
  maxEnemies = 75;
  mapWidth = width * 5;
  mapHeight = height * 5;
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
  isPaused = false;
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  blockers = new ArrayList();
  for (int i = 0; i <= 250; i ++)
    blockers.add(new Blocker(new PVector(random(mapWidth), random(mapHeight)), 100));
  /// P1 TODO: Think about the value and uses of pauseTime over the rest of this method. Are you sure you're doing what you want to be doing?
  p = new Player(new PVector(mapWidth / 2, mapHeight / 2), new PVector(mapWidth / 2, mapHeight / 2), 15, millis() - pauseTime, 10, 10, 0, 1, 4.0);
  pauseTime = 0;
  pauseStart = 0;
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
    if (!isPaused)
    {
      background(127.5);
      fill(127.5);
      stroke(255);
      rect(mapWidth / 2, mapHeight / 2, mapWidth, mapHeight);
      noStroke();
      p.show();
      camera(p.loc.x, p.loc.y, (height / 2) / tan(PI * 30 / 180), p.loc.x, p.loc.y, 0, 0, 1, 0);
      PVector vel = new PVector(100, 100);
      PVector loc = new PVector(mouseX, mouseY);
      image(img1, vel);
      image(img2, loc);
      PVector offset = PVector.sub(loc, vel);
      println(collisionDetection(offset));
      if (millis() - questTime - pauseTime >= 5000)
      {
        questTime = millis() - pauseTime;
        int totalEnemies = enemies.size();
        int randomEnemy = int(random(totalEnemies));
        Enemy e =  enemies.get(randomEnemy);
        e.partOfQuest = true;
      }
      fill(0);
      textAlign(LEFT, TOP);
      text("HP:", p.loc.x - (width / 2), p.loc.y - (height / 2));
      text("" + p.hp + " / " + p.maxHP, p.loc.x - (width / 2), p.loc.y - (height / 2) + fontSize);
      textAlign(RIGHT, TOP);
      text("XP:", p.loc.x + (width / 2), p.loc.y - (height / 2));
      text("" + p.xp + " / " + p.level, p.loc.x + (width / 2), p.loc.y - (height / 2) + fontSize);
      text("Level: " + p.level, p.loc.x + (width / 2), p.loc.y - (height / 2) + 64);
      for (int i = 0; i <= blockers.size() - 1; i ++)
      {
        Blocker b = (Blocker) blockers.get(i);
        b.show();
      }
      if (enemies.size() < maxEnemies)
      {
        enemies.add(new EnemyA(new PVector(0, 0), new PVector(random(mapWidth), random(mapHeight)), millis() - pauseTime, int(random(250, 2500)), millis() - pauseTime));
        Enemy e =  enemies.get(enemies.size() - 1);
        while (dist (e.loc.x, e.loc.y, p.loc.x, p.loc.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
          e.loc.set(random(mapWidth), random(mapHeight), 0);
      }       
      if (enemies.size() < maxEnemies)
      {
        enemies.add(new EnemyB(new PVector(0, 0), new PVector(random(mapWidth), random(mapHeight)), millis() - pauseTime, int(random(250, 2500)), millis() - pauseTime));
        Enemy e =  enemies.get(enemies.size() - 1);
        while (dist (e.loc.x, e.loc.y, p.loc.x, p.loc.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
          e.loc.set(random(mapWidth), random(mapHeight), 0);
      }
      if (enemies.size() < maxEnemies)
      {
        enemies.add(new EnemyC(new PVector(0, 0), new PVector(random(mapWidth), random(mapHeight)), millis() - pauseTime, int(random(250, 2500)), millis() - pauseTime));
        Enemy e =  enemies.get(enemies.size() - 1);
        while (dist (e.loc.x, e.loc.y, p.loc.x, p.loc.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
          e.loc.set(random(mapWidth), random(mapHeight), 0);
      }
      if (enemies.size() < maxEnemies)
      {
        enemies.add(new EnemyD(new PVector(0, 0), new PVector(random(mapWidth), random(mapHeight)), millis() - pauseTime, int(random(250, 2500)), millis() - pauseTime));
        Enemy e = enemies.get(enemies.size() - 1);
        while (dist (e.loc.x, e.loc.y, p.loc.x, p.loc.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
          e.loc.set(random(mapWidth), random(mapHeight), 0);
      }
      /*if (enemies.size() < maxEnemies)
       {
       enemies.add(new EnemyE(new PVector(0, 0), new PVector(random(mapWidth), random(mapHeight)), millis() - pauseTime, int(random(250, 2500)), millis() - pauseTime));
       Enemy e = enemies.get(enemies.size() - 1);
       while (dist (e.loc.x, e.loc.y, p.loc.x, p.loc.y) < 250 + (p.pSize / 2) + (e.eSize / 2))
       e.loc.set(random(mapWidth), random(mapHeight), 0);
       }*/
      for (int i = 0; i <= enemies.size() - 1; i ++)
      {
        Enemy e = enemies.get(i);
        if (e.exists)
          e.show();
      }
      if ((mousePressed || autoFireOn))
      {
        PVector bulletVel = new PVector(p.loc.x - mouseX, p.loc.y - mouseY);
        int timeSinceLastShot = millis() - p.shootTime - pauseTime;
        if (weapon == 1 && timeSinceLastShot >= 250)
        {
          bullets.add(new StraightBullet(bulletVel, copy(p.loc), 5, 4, 250, 4.5, true, false));
          p.shootTime = millis() - pauseTime;
        }
        if (weapon == 2 && timeSinceLastShot >= 175)
        {
          bullets.add(new StraightBullet(bulletVel, copy(p.loc), 5, 2, 225, 5, true, true));
          p.shootTime = millis() - pauseTime;
        }
      }
      for (int i = 0; i <= enemies.size() - 1; i ++)
      {
        Enemy e = enemies.get(i);
        if (!e.exists)
        {
          enemies.remove(i);
          break;
        }
      }
      for (int i = 0; i <= bullets.size() - 1; i ++)
      {
        Bullet b = bullets.get(i);
        if (!b.exists)
        {
          bullets.remove(i);
          break;
        }
      }
      
      for (Bullet b : bullets)
      {
        b.show();
        b.run();
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
    isPaused = !isPaused;
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
    if (p.hp >= p.maxHP)
      p.hp = p.maxHP;
    else
      p.hp ++;
  }
  if (key == 'x')
    p.xp += 1;
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

void bulletBehavior(ArrayList<Enemy> enemies, Bullet b)
{
  for (Enemy e : enemies)
  {
    if (b.exists && dist(e.loc.x, e.loc.y, b.loc.x, b.loc.y) <= e.eSize / 2 + (b.bulletSize / 2))
    {
      if (!b.piercing)
        b.exists = false;
      e.hp -= b.damage;
    }
    if (e.hp <= 0)
    {
      e.exists = false;
      if (e.partOfQuest)
        p.xp += e.value + 10;
      else
        p.xp += e.value;
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


abstract class Enemy
{
  PVector loc1, loc2;
  int eSize, moveTime, moveChange, shootTime, hp, value;
  boolean partOfQuest, exists;

  Enemy(PVector loc1, PVector loc2, int eSize, int moveTime, int moveChange, int shootTime, int hp, int value, boolean partOfQuest, boolean exists)
  {
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.eSize = eSize;
    this.moveTime = moveTime;
    this.moveChange = moveChange;
    this.shootTime = shootTime;
    this.hp = hp;
    this.value = value;
    this.partOfQuest = partOfQuest;
    this.exists = exists;
  }

  void show()
  {
    if (millis() - moveTime - pauseTime >= moveChange)
    {
      loc1 = PVector.random2D();
      moveTime = millis() - pauseTime;
      moveChange = int(random(250, 1250));
    }
    loc2.add(loc1);
    if (loc2.x > mapWidth - (eSize / 2))
      loc2.x = mapWidth - (eSize / 2);
    else if (loc2.x < (eSize / 2))
      loc2.x = (eSize / 2);
    if (loc2.y > mapHeight - (eSize / 2))
      loc2.y = mapHeight - (eSize / 2);
    else if (loc2.y < (eSize / 2))
      loc2.y = (eSize / 2);
    if (partOfQuest)
      stroke(255);
    ellipse(loc2.x, loc2.y, eSize, eSize);
    noStroke();
  }
}


class Enemy
{
  boolean[] hitBy;
  PVector loc1, loc2;
  int eSize, moveTime, moveChange, shootTime, HP, value;
  boolean fatal, partOfQuest;

  Enemy(boolean[] hitBy, PVector loc1, PVector loc2, int eSize, int moveTime, int moveChange, int shootTime, int HP, int value, boolean fatal, boolean partOfQuest)
  {
    this.loc1 = loc1;
    this.loc2 = loc2;
    this.eSize = eSize;
    this.moveTime = moveTime;
    this.moveChange = moveChange;
    this.shootTime = shootTime;
    this.HP = HP;
    this.value = value;
    this.fatal = fatal;
    this.hitBy = hitBy;
    this.partOfQuest = partOfQuest;
  }
}

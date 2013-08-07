void showUI()
{
  fill(0);
  textAlign(LEFT, TOP);
  text("HP:", p.loc.x - (width / 2), p.loc.y - (height / 2));
  text("" + p.hp + " / " + p.maxHP, p.loc.x - (width / 2), p.loc.y - (height / 2) + fontSize);
  textAlign(RIGHT, TOP);
  text("XP:", p.loc.x + (width / 2), p.loc.y - (height / 2));
  text("" + p.xp + " / " + p.level, p.loc.x + (width / 2), p.loc.y - (height / 2) + fontSize);
  text("Level: " + p.level, p.loc.x + (width / 2), p.loc.y - (height / 2) + 64);
}

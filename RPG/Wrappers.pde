void image(PImage img, PVector loc)
{
  image(img, loc.x, loc.y);
}

PVector copy(PVector vec)
{
  return new PVector(vec.x, vec.y);
}

void ellipse(PVector center, int w, int h)
{
  ellipse(center.x, center.y, w, h);
}

PVector randomLocation()
{
  return new PVector(random(mapWidth), random(mapHeight));
}

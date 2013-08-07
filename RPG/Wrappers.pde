void image(PImage img, PVector loc)
{
  image(img, loc.x, loc.y);
}

PVector copy(PVector vec)
{
  return new PVector(vec.x, vec.y);
}

import java.util.Calendar; //<>//

void setup() {
  
  size(1600, 800);
  backgroundGradient(#17D0FC, #1965F7);
  
  float arcSize = random(30, 50);
  float arcStart = 0;
  float arcEnd = random(360);
  
  noFill();
  for (int y = 0; y < height - 1; y += arcSize) {
    for (int x = 0; x < width - 1; x += arcSize) {
      stroke(255, 255, 255, random(200, 255));
      strokeWeight(random(10));
      arc(x, y, arcSize, arcSize, radians(arcStart), radians(arcEnd));
      arcStart = arcEnd;
      arcEnd = arcEnd + 90;
    }
  }
}

void draw() {
  if (keyPressed) {
    if (key == 's' || key == 'S') saveFrame(timestamp()+".png");
  }
}

void backgroundGradient(color c1, color c2) {
  loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float t = map(x + y, 0, width + height, 0, 1);
      color c = lerpColor(c1, c2, t);
      pixels[y * width + x] = c;
    }
  }
  updatePixels();
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty_%1$tm_%1$td_%1$tH_%1$tM_%1$tS", now);
}

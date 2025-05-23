import java.util.Calendar;

void setup() {
  background(255);
  size(1000, 780);
  noFill();
  float offset = 10;
  float size = 100;
  for (float x = offset; x <= width; x += size + offset) {
    for (float y = offset; y <= height; y += size + offset) {
      drawInception(x, y, size);
    }
  }
  saveFrame(timestamp() + ".png");
}

void drawInception(float x, float y, float size) {
  for (int i = 0; i <= 30; i += 10) {
    drawSquare(x + i, y + i, size - (i * 2));
  }
}

void drawSquare(float x, float y, float size) {
  stroke(random(255), random(255), random(255));
  beginShape();
  vertex(rand(x), rand(y));
  vertex(rand(x), rand(y + size));
  vertex(rand(x + size), rand(y + size));
  vertex(rand(x + size), rand(y));
  endShape(CLOSE);
}

float rand(float num) {
  return num + random(-3, 3);
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty_%1$tm_%1$td_%1$tH_%1$tM_%1$tS", now);
}

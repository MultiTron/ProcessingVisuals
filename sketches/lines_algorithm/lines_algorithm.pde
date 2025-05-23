import java.util.Calendar;    

void setup() {
  size(500, 500);
  background(255);

  drawDiagonalLR();
  drawDiagonalRL();
  drawVertical();
  drawHorizontal();
  
  saveFrame(timestamp() + ".png");
}

void drawVertical() {
  stroke(#FCFC0A);

  for (int i = 0; i <= width; i += 5) {
    line(i, random(height), i, random(height));
  }
}

void drawHorizontal() {
  stroke(0);

  for (int i = 0; i <= width; i += 5) {
    line(random(width), i, random(width), i);
  }
}
void drawDiagonalLR() {
  stroke(#FF0900);

  for (int y = 0; y < height; y += 5) {
    float x1 = random(width);
    float y1 = y;

    float length = random(50, 300);

    float x2 = x1 + length;
    float y2 = y1 + length;

    if (x2 > width || y2 > height) {
      float maxLength = min(width - x1, height - y1);
      x2 = x1 + maxLength;
      y2 = y1 + maxLength;
    }

    line(x1, y1, x2, y2);
  }
}
void drawDiagonalRL() {
  stroke(#00A8FF);

  for (int y = 0; y < height; y += 5) {
    float x1 = random(width);
    float y1 = y;

    float length = random(50, 300);

    float x2 = x1 - length;
    float y2 = y1 + length;

    if (x2 < 0 || y2 > height) {
      float maxLength = min(x1, height - y1);
      x2 = x1 - maxLength;
      y2 = y1 + maxLength;
    }

    line(x1, y1, x2, y2);
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty_%1$tm_%1$td_%1$tH_%1$tM_%1$tS", now);
}

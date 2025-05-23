import java.util.Calendar;

void setup() {
  size(800, 600);
  noStroke();
  frameRate(10);
}

void draw() {
  if (mousePressed) {
    background(#F7CDCD);

    float x, y;
    boolean changeColor = false;
    for (int i = 0; i <= 5; i++) {
      if (changeColor) {
        fill(250, 72, 28, 220 - i * 20);
      } else {
        fill(245, 139, 10, 220 - i * 20);
      }
      x = random(width);
      y = random(height);
      rect(x, y, random(x - width, width - x), random(y - height, height - y));
      changeColor = !changeColor;
    }
  }
  
  if (keyPressed) {
    if (key == 's' || key == 'S') saveFrame(timestamp() + ".png");
  } 
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty_%1$tm_%1$td_%1$tH_%1$tM_%1$tS", now);
}

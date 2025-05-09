import java.util.Calendar;

void setup() {
  size(1200, 800);
  background(255);
   
  for (int y = 20; y < height-70; y += 80) {
    for (int x = 20; x < width-90; x += 100) {
      drawShape(x, y, 100, 80);
    }
  }
}

void drawShape(int posX, int posY, int sizeX, int sizeY) {

  float startingPosX, startingPosY, previousPosX, previousPosY, newValue;
  boolean flag = false;

  startingPosX = random(posX, posX + sizeX);
  startingPosY = random(posY, posY + sizeY);

  System.out.println(startingPosX + " " + startingPosY);

  previousPosX = startingPosX;
  previousPosY = random(posY, posY + sizeY);

  System.out.println(previousPosX + " " + previousPosY);

  noFill();
  stroke(0);

  line(startingPosX, startingPosY, previousPosX, previousPosY);

  for (int i = 0; i < 10; i++) {

    if (!flag) {
      newValue = random(posX, posX + sizeX);
      line(previousPosX, previousPosY, newValue, previousPosY);
      previousPosX = newValue;
    } else {
      newValue = random(posY, posY + sizeY);
      line(previousPosX, previousPosY, previousPosX, newValue);
      previousPosY = newValue;
    }

    flag = !flag;
  }
  line(previousPosX, previousPosY, startingPosX, startingPosY);
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

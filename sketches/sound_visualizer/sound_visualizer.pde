import ddf.minim.*;
import ddf.minim.analysis.*;
import java.util.Calendar;

Minim minim;
AudioPlayer player;
FFT fft;

String[] songFiles = {
  "music/Milkyway.mp3",
  "music/Pandora.mp3",
  "music/Only Fans.mp3",
  "music/Fokusi.mp3",
  "music/Cypher.mp3",
  "music/Chasat.mp3"
};

int currentSongIndex = 0;

int bands = 128;
float smoothing = 0.8;
float[] smoothedBands;

void setup() {
  fullScreen();
  minim = new Minim(this);

  loadSong(currentSongIndex);

  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.logAverages(22, 3);

  smoothedBands = new float[bands];
}

void draw() {
  background(0);
  fft.forward(player.mix);

  // Automatically play next song when current one ends
  if (!player.isPlaying()) {
    nextSong();
  }

  // Calculate average amplitude for pulsing circles
  float amplitude = 0;
  for (int i = 0; i < player.mix.size(); i++) {
    amplitude += abs(player.mix.get(i));
  }
  amplitude /= player.mix.size();

  translate(width / 2, height / 2);
  float radius = 200;

  // Pulsing Circles
  noFill();
  colorMode(HSB, 360, 100, 100);
  float pulse = amplitude * 400;
  for (int i = 0; i < 3; i++) {
    stroke((frameCount * 2 + i * 60) % 360, 100, 100);
    strokeWeight(2 - i * 0.4);
    ellipse(0, 0, pulse + i * 60, pulse + i * 60);
  }

  // Radial Spectrum
  for (int i = 0; i < bands; i++) {
    float bandValue = fft.getBand(i);
    smoothedBands[i] = lerp(smoothedBands[i], bandValue, 1 - smoothing);
    float amplitudeBand = smoothedBands[i];

    float angle = map(i, 0, bands, 0, TWO_PI);
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    float x2 = cos(angle) * (radius + amplitudeBand * 3.5);
    float y2 = sin(angle) * (radius + amplitudeBand * 3.5);

    strokeWeight(3); // Thicker lines
    stroke(map(i, 0, bands, 0, 360), 100, 100);
    line(x, y, x2, y2);
  }

  // Draw current song title
  fill(255);
  textAlign(CENTER, TOP);
  textSize(20);
  text(getCurrentSongTitle(), 0, -height / 2 + 20); // Centered at top


  // Screenshot key (press 'S')
  if (keyPressed) {
    if (key == 's' || key == 'S') saveFrame(timestamp() + ".png");
  }
}

void mousePressed() {
  nextSong();
}

void loadSong(int index) {
  if (player != null) {
    player.close();
  }
  player = minim.loadFile(songFiles[index], 1024);
  player.play();
}

void nextSong() {
  currentSongIndex = (currentSongIndex + 1) % songFiles.length;
  loadSong(currentSongIndex);
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty_%1$tm_%1$td_%1$tH_%1$tM_%1$tS", now);
}

String getCurrentSongTitle() {
  String fullPath = songFiles[currentSongIndex];
  String fileName = fullPath.substring(fullPath.lastIndexOf("/") + 1);
  if (fileName.endsWith(".mp3")) {
    fileName = fileName.substring(0, fileName.length() - 4);
  }
  return fileName;
}

import processing.sound.*;
SoundFile fiveMinutesSound;
SoundFile finish;

void setup() {
  size(500, 500);
  background(0);
  noLoop();
  textAlign(CENTER, CENTER);
  textSize(100);
  fiveMinutesSound = new SoundFile(this, "fiveminutes.wav");
  finish = new SoundFile(this, "finish.wav");
}

int start = 999999; // makes it so that circle is completely filled before start 
int startTime = 3600; // seconds to start with (should be 3600)
color clockPassed = color(0, 0, 0);
color clockRemaining = color(255, 255, 0);
color bgColour = color(0, 0, 0);
boolean fiveMinutesLeft = false;
boolean running = false;

void draw() {
  background(bgColour);
  fill(clockRemaining);
  ellipse(250, 250, 480, 480);
  fill(clockPassed);
  arc(250, 250, 480, 480, -TAU/4.0, (millis()-start)/1000.0*TAU/startTime - TAU/4.0);
  fill(lerpColor(clockPassed, clockRemaining, 0.5));
  if (running) {
    text(str((startTime - int((millis()-start)/1000.0)) / 60) + ':' + nf(((startTime - int((millis()-start)/1000.0))) % 60, 2), 250, 250);
  }
  if (!fiveMinutesLeft && (startTime - (millis()-start)/1000.0 < 300)) {
    fiveMinutesSound.play();
    fiveMinutesLeft = true;
  }
  
  if (startTime - (millis()-start)/1000.0 <= 0) {
    finish.play();
    noLoop();
  }
}

void keyReleased() {
  if (key == ' ') {
    running = true;
    start = millis();
    loop();
    fiveMinutesLeft = false;
  }
}

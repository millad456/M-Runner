class Bullet {
  float x, y = p.y -10; 
  int frame = 0, health = 5, speed = 10, spread = 4, muzzleSpreadX, muzzleSpreadY;


  Bullet(float tempX) {
    x = tempX;
  } 


  void run() {
    setup();
    display();
  }

  void setup() {
    muzzleSpreadX = (int) random(-5, 5);
    muzzleSpreadY = (int) random(-1, 1);
  }
  void display() {
    if (frame == 0) {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      ellipse(x, y, 20 + muzzleSpreadX, 10 + muzzleSpreadX);
      frame++;
    } else if (frame == 1) {
      ellipse(x, y, 30 + muzzleSpreadX, 10 + muzzleSpreadX);
      stroke(0);
      frame++;
      x = x + (int) random(-spread, spread);
    } else {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      ellipse(x, y, 5, 20);
      if (pause == 0)y = y - speed;
    }
  }
}

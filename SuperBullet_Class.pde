class SuperBullet {
  float x, y = p.y -10; 
  int frame = 0, health = 5, speed = 15;

  SuperBullet(float tempX) {
    x = tempX;
  } 

  void run() {
    if (frame == 0) {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      ellipse(x, y, 20, 10);
      frame++;
    } else if (frame == 1) {
      ellipse(x, y, 30, 10);
      stroke(0);
      frame++;
    } else {
      stroke(255, 255, 255);
      fill(255, 0, 0);
      ellipse(x, y, 8, 30);
      if (pause == 0)y = y - speed;
    }
  }
}

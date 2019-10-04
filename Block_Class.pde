class Block {
  float y, x, radius, h = 60, w = 60;
  int type = (int)random(1, 5), frame, health, rand;

  Block(float tempy) {
    y = 0-tempy;
  }

  //generates random hp values for the destructable blocks
  void setup() {
    x = (int)random(0, 8);
    frame = 1;

    switch(type) {
    case 1: 
      //health = (int)random(p.damage, p.damage*3);
      health = (int)random(1, 3);
      break;
    case 2: 
      //health = (int)random(p.damage*4, p.damage*5+1);
      health = (int)random(4, 6);
      break;
    case 3: 
      //health = (int)random(p.damage*6, p.damage*7+1);
      health = (int)random(6, 10);
      break;
    case 4: 
      //health = (int)random(p.damage*12, p.damage*15+1);
      health = (int)random(12, 16);
      break;
    }
  }

  void run() {
    checkDead();
    display();
    if (pause == 0) {
      if (type == 4) y += (speed*0.75);
      else y += speed;
    }
  }
  void checkDead() {
    if (health <= 0) {
      frame = 0;//still doesn't destroy it
    }
  }

  void display() {
    if (type == 1 ||type == 2 ||type == 3 ||type == 4) {
      if (frame == 1) {
        fill(0);
        strokeWeight(8);
        stroke(255);
        rect(x*w, y, h, w);
        fill(255);
        text(health, x*w +w/4, y+38);
      } else if (frame == 2) {
        fill(255);
        strokeWeight(1);
        stroke(255);
        rect(x*w, y, h, w);
        fill(0);
        text(health, x*w +w/4, y+38);
        frame = 1;
      }
    }
  }
}

int tick = 0, shakeFrame = 0, score = 0, gameScreen = 1, blockHealthLvl, song, bonus = 0, heartX, heartY = 770;
float speed = 1, fast = speed*2, pause, regular = speed; //whenever the speed increases, so do both of these values
PFont f;
Player p = new Player();
Star[] stars = new Star[100];
ArrayList<Bullet> bullet = new ArrayList();
ArrayList<SuperBullet> sbullet = new ArrayList();
ArrayList<Block> block = new ArrayList();
ArrayList <Particle> particle = new ArrayList();


void setup() {
  size(480, 852);
  background(255);
  stroke(0);
  fill(255);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  //creats blocks at their starting position
  for (int i = 0; i <= 11; i++) {
    block.add ( new Block(i*64));
  }
  for (Block currentBlock : block ) { 
    currentBlock.setup();
  }
}
//main method 
void draw() {
  background(0);
  stroke(255);

  if (shakeFrame >= 0) shake();

  if (p.health >= 0) {
    p.run();
    checkShoot();
    blockCol();
    drawHUD();
    newBlocks();


    //draw stars
    for (int i = 0; i < stars.length; i++) {
      stars[i].run();
    }
    //draw all bullets
    for (Bullet currentBullet : bullet ) { 
      currentBullet.run();
    }
    for (SuperBullet currentsBullet : sbullet ) { 
      currentsBullet.run();
    }
    //for particles
    for(int i = 0; i < particle.size(); i++){
    particle.get(i).run();
    if (particle.get(i).frame == 0) particle.remove(i);
  }
    //draw blocks after bullets
    for (Block currentBlock : block ) { 
      currentBlock.run();
    }  

    println("Bonus: " + bonus + ", Speed: " + speed + ", Damage: " + p.damage + ", Tick: " + tick + ", Health: " + p.health);
    endCalc();
  } else {
    f = createFont("Arial", 80, true);
    textFont(f, 20); 
    text("Game Over", (width/2)-65, height/2);
    text("Score: " + score, (width/2)-65, (height/2)+20);
  }
}                  //end of main method



//sets up blocks that hit the bottom
void newBlocks() {
  for (Block currentBlock : block ) {
    if (currentBlock.y + currentBlock.h > 746 && currentBlock.frame != 0) p.health--;
    if (currentBlock.y + currentBlock.h > 746) {
      currentBlock.y = 0-60;
      currentBlock.setup();
    }
  }
}


//does the calculations at the end of every frame
void endCalc() {
  //for the bonus overflow thing
  if (bonus >= 1900) {
    p.damage++;
    bonus = 0;
  }
  //use this code to remove a bullet
  for (int i = 0; i < bullet.size(); i++) { 
    Bullet b = bullet.get(i); 
    if (b.y < 0 || b.health == 0) {
      bullet.remove(i);
    }
  }
  for (int i = 0; i < sbullet.size(); i++) { 
    SuperBullet sb = sbullet.get(i); 
    if (sb.y < 0 ) {
      sbullet.remove(i);
    }
  }
  //deals with pause frames
  if (pause > 0) pause--;

  //add tick and variable trace
  tick++;

  //speed up
  if (tick > 2400) {

    speed = speed * 1.009;
    regular = speed;
    fast = speed *2;
    tick = tick% 1200;
  }
}

//check bullet-block collision
void blockCol() {
  for (Block currentBlock : block ) { 
    for (Bullet currentBullet : bullet ) { 
      if (currentBullet.x >= currentBlock.x*currentBlock.h && currentBullet.x <= currentBlock.x*currentBlock.h + currentBlock.w && currentBullet.y <= currentBlock.y + 60 && currentBlock.health >0) {
        currentBlock.health = currentBlock.health - p.damage;
        currentBullet.health = 0;
        shakeFrame = 0;
        if (currentBlock.health <= 0){
          for(int j = 0; j < 20; j++) particle.add(new Particle(currentBlock.x*currentBlock.w + currentBlock.w/2, currentBlock.y+ currentBlock.w/2));
          pause = 3;
        }
        currentBlock.frame = 2;
        score = score + (p.damage*10);
      }
    }
    for (SuperBullet currentsBullet : sbullet ) { 
      if (currentsBullet.x >= currentBlock.x*currentBlock.h && currentsBullet.x <= currentBlock.x*currentBlock.h + currentBlock.w && currentsBullet.y <= currentBlock.y + 60 && currentBlock.health >0) {
        currentBlock.health = currentBlock.health - p.damage*10;
        shakeFrame = 0;
        pause = 6;
        for(int j = 0; j < 20; j++) particle.add(new Particle(currentBlock.x*currentBlock.w + currentBlock.w/2, currentBlock.y+ currentBlock.w/2));
        currentBlock.frame = 2;
        score = score + (p.damage*10);
      }
    }
  }
}

//check if the player is shooting
void checkShoot() {
  if (keyPressed && key == 'e' && p.frame == 0 && bonus >= 200) {
    if (pause == 0) p.frame = 1;
    if (pause == 0) sbullet.add ( new SuperBullet(p.x));
    bonus -= 200;
  } else if ((mousePressed && mouseButton == LEFT && p.frame == 0) || (keyPressed && key == ' ' && p.frame == 0)) {
    if (pause == 0) p.frame = 1;
    if (pause == 0) bullet.add ( new Bullet(p.x));
  }
  if (((mousePressed && mouseButton != LEFT ) || !mousePressed) && (keyPressed != true)) {
    if (pause == 0) bonus++;
  }

  //speed up time!                                             
  if (mouseY >= 745) {
    speed = fast;
    for (Bullet currentBullet : bullet ) { 
      currentBullet.speed = 20;
    }
    for (int i = 0; i < stars.length; i++) {
      stars[i].speedx2 = true;
    }
    if (((mousePressed && mouseButton != LEFT ) || !mousePressed) && (keyPressed != true)) {
      if (pause == 0) bonus += 2;
    }
  } else {
    speed = regular;
    for (Bullet currentBullet : bullet ) { 
      currentBullet.speed = 10;
    }
    for (int i = 0; i < stars.length; i++) {
      stars[i].speedx2 = false;
    }
  }
}

//draw heads up display
void drawHUD() {
  f = createFont("Arial", 80, true);
  textFont(f, 20);

  //does the bonus bar
  noFill();
  stroke(128);
  rect(80, 800, 380, 20, 5);
  noStroke();
  if (mouseY >= 745) fill(191);       // changes colour if bonues
  else fill(128);
  rect(80, 800, bonus/5, 20, 5);
  fill(255);
  text("Bonus: ", 10, 818);

  //score display
  text("Score: " + score, 10, 780);
  //heart display
  for (int i = 0; i <= p.health; i++) {
    heartX = 450 - (i*20);
    smooth();
    noStroke();
    fill(255, 0, 0);
    beginShape();
    vertex(heartX, heartY); 
    bezierVertex(heartX, heartY-10, heartX+20, heartY-5, heartX, heartY+12); 
    vertex(heartX, heartY); 
    bezierVertex(heartX, heartY-10, heartX-20, heartY-5, heartX, heartY+12); 
    endShape();
  }


  //line of defense
  for (int i = 0; i <= width; i++) {
    stroke(255);
    if (i%8 == 0) line(i, 745, i+4, 750);
  }
}
void shake() {
  if (shakeFrame == 0) shakeFrame ++;
  if (shakeFrame == 1||shakeFrame == 2) {
    translate(1, 0);
    shakeFrame++;
  } else if (shakeFrame == 3||shakeFrame == 4||shakeFrame == 5||shakeFrame == 6) {
    translate(-1, 0);
    shakeFrame++;
  } else if (shakeFrame == 7||shakeFrame == 8) {
    translate(1, 0);
    shakeFrame++;
  } else if (shakeFrame == 9) shakeFrame = -1;
}

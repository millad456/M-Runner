  class Player {
    
    float x = 360, y = 720, easing = 0.15;
    int frame = 0, health = 4, damage = 1;
    boolean canShoot = true;
    
    //throw everything in here
    void run(){
      //these three lines of code describe the easing
      float targetX = mouseX;
      float dx = targetX - x;
      if (pause == 0)x += dx * easing;
      
      shoot();
    }
    
    //different frames
    void shoot(){
      strokeWeight(1);
      if (frame == 0){ //resting position
        stroke(255);
        fill(0,0,0);
        quad(x-24, y+2, x-12, y-10, x-17, y+2, x-12, y+14);  // left part
        quad(x+24, y+2, x+12, y-10, x+17, y+2, x+12, y+14);  // right part
        fill(0,255,0);
        triangle(x-6,y+8,x+6,y+8,x,y-10); //triangle
      }
      else if (frame >= 1 && frame <= 4){ //resting position
        stroke(255);
        fill(0,0,0);
        quad(x-24, y+2, x-12, y-10, x-17, y+2, x-12, y+14);  // left part
        quad(x+24, y+2, x+12, y-10, x+17, y+2, x+12, y+14);  // right part
        fill(255,255,0);
        triangle(x-6,y+14,x+6,y+14,x,y-4);//triangle
        if (pause == 0) frame++;
      }
      else if (frame == 5){
        stroke(255);
        fill(0,0,0);
        quad(x-24, y+2, x-12, y-10, x-17, y+2, x-12, y+14);  // left part
        quad(x+24, y+2, x+12, y-10, x+17, y+2, x+12, y+14);  // right part
        fill(255,255,0);
        triangle(x-6,y+12,x+6,y+12,x,y-6);//triangle
        if (pause == 0) frame ++;
      }
      else if (frame == 6){
        stroke(255);
        fill(0,0,0);
        quad(x-24, y+2, x-12, y-10, x-17, y+2, x-12, y+14);  // left part
        quad(x+24, y+2, x+12, y-10, x+17, y+2, x+12, y+14);  // right part
        fill(255,255,0);
        triangle(x-6,y+10,x+6,y+10,x,y-8);//triangle
        if (pause == 0) frame++;
      }
      else if (frame == 7){ //resting position
        stroke(255);
        fill(0,0,0);
        quad(x-24, y+2, x-12, y-10, x-17, y+2, x-12, y+14);  // left part
        quad(x+24, y+2, x+12, y-10, x+17, y+2, x+12, y+14);  // right part
        fill(0,255,0);
        triangle(x-6,y+8,x+6,y+8,x,y-12); //triangle
        if (pause == 0) frame=0;
      }
      
    }
  
  }

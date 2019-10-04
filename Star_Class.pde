  class Star{
    float x = random(0,width), y = random(0, height);
    int  rand = (int) random(1,4), speed = rand;
    boolean speedx2 = false;
    
    void run(){
      fill(255);
      noStroke();
      if (speed == 2){
        ellipse(x,y,1,1);
        if (pause == 0){
          if(speedx2) y = y + speed*2;
          else y = y + speed;
        }
      }
      else if (speed == 4){
        ellipse(x,y,2,2);
        if (pause == 0){
          if(speedx2) y = y + speed*2;
          else y = y + speed;
        }
      }
      else if (speed == 6){
        ellipse(x,y,3,3);
        if (pause == 0){
          if(speedx2) y = y + speed*2;
          else y = y + speed;
        }
      }
      if (y >= 852){
        y = 0;
        x = random(0,width);
        rand = (int) random(1,4);
        speed = 2*rand;
      }
    }
  }

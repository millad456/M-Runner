class Particle{
  PVector pos;
  PVector vel;
  int frame = 60;
  
  Particle(float x, float y){
    pos = new PVector(x,y);
    vel = PVector.random2D().mult((int)random(1,4));
  }
  
  void run(){
    fill(255);
    noStroke();
    circle(pos.x, pos.y, frame/12);
    pos = pos.add(vel);
    frame--;
  }

}

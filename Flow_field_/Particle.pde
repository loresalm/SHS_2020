public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
   
  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
  }


  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);

    edges();
  }

  void applyForce(PVector force) {
    acc.add(force); 
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(pos.heading());
    stroke(0,10);
    strokeWeight(10);
    point(0,0);
    //line(pos.x, pos.y, previousPos.x, previousPos.y);
    popMatrix();
    updatePreviousPos();
  }

  void edges() {
    if (pos.x > width) {
      pos.x = random(0,width-1) ;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = random(0,width-1);
      updatePreviousPos();
    }
    if (pos.y > height) {
      pos.y = random(0,height-1);
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = random(0,height-1);
      updatePreviousPos();
    }
  }

  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }

  void follow(VectorField v){

    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);

    this.applyForce( v.get_vector( x, y) );

  }

}
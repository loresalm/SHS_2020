
// simulation parameters
int scl = 5;
int nb_par = 1000;


// GLOBAL variables
int cols = 0;
int rows = 0;
VectorField vf;
Particle [] parts = new Particle [nb_par];


void setup(){
  background(255);
  size(1000, 1000);
  
  // generating particles
  for(int i = 0; i <nb_par; i+=1){
    PVector start = new PVector(random(0,width),random(0,height));
    parts[i] = new Particle(start,1);
  }

  vf = new VectorField("medium.jpg");
  
}

void draw(){

  vf.updateField();
  
  for (Particle p : parts) {
     p.follow(vf);
     p.update();
     p.show(); 
   }
  
}


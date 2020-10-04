
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
    PVector start = new PVector(random(250,width-1),random(0,300));
    parts[i] = new Particle(start,random(2,8));
  }

  vf = new VectorField("medium.jpg");
  
}

void draw(){
  
  for (Particle p : parts) {
     p.follow(vf);
     p.update();
     p.show(); 
   }
  
}



// simulation parameters
int scl = 5;
int nb_par = 1000;
int size_sim = 1000;


// GLOBAL variables
int cols = 0;
int rows = 0;
PVector [] ff = new PVector[50*50];
Particle [] parts = new Particle [nb_par];


PImage img;


void setup(){
  background(255);
  size(size_sim, size_sim);
  cols = floor(width/scl);
  rows = floor(height/scl);
  img = loadImage("medium.jpg");
  img.loadPixels();
  
  int dim = cols*rows;

  
  
  for(int i = 0; i <nb_par; i+=1){
    //PVector start = new PVector(random(0,width-1),random(0,height-1));
    PVector start = new PVector(random(250,width-1),random(0,300));
    parts[i] = new Particle(start,random(2,8));
  }
  
 
  float [] f = new float[dim];
  float [] o = new float[dim];
  
 
  for (int j = 0; j < dim; j += 1) { 
    f[j] = img.pixels[j];
    o[j] = img.pixels[j];
  } 
  
  float f_min = min(f);
  float f_max = max(f);
  for (int i = 0; i < dim; i += 1) {
    o[i] = map(f[i], f_min, f_max, 0, 255);
    f[i] = map(f[i], f_min, f_max, 0, TWO_PI);

  } 
  
  ff = draw_field(0,0, rows, cols, scl,f, o);
  
  for(int t = 0; t < 10; t += 1){
  for (Particle p : parts) {
     p.follow(ff,cols);
     p.run();   
   }
  }
  
}

void draw(){
  
  for (Particle p : parts) {
     p.follow(ff,cols);
     p.run();   
   }
  
}


PVector [] draw_field(int posx,int posy, int _rows, int _cols, int _scl, float[] img,float[] original){
  PVector [] _ff = new PVector[_rows*_cols];
  int i = 0;
  float angle = 0; 
  PVector v;
  for(int y = posy; y < _rows; y ++){
        //println("--> i: ",i, " y: ", y);
    for(int x = posx; x < _cols; x ++){
      //println(" - > ",_cols);
       i = (x + y * _cols);
       //println("i: ",i, " x: ", x, " y: ", y);
       angle = img[i];
       v = PVector.fromAngle(angle);
       _ff[i] = v;
       //fill(color(original[i]));
       //print(original[i]);
       //noStroke();
       //rect(x*_scl, y * _scl,_scl,_scl);
       pushMatrix();
       translate(x*_scl, y * _scl);
       rotate(v.heading());
       stroke(0,100); 
       //line(0,0,scl,0);
       popMatrix();
       
    }
  }
  return _ff;
  
}

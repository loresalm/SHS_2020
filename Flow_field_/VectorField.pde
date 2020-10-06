public class VectorField {

    PVector [] ff;


    VectorField(String imgFileName){

        PImage img = loadImage(imgFileName);
        img.loadPixels();

        cols = floor(width/scl);
        rows = floor(height/scl);
        int dim = cols*rows;
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
    }


    PVector [] get_field (){
        return ff;
    }

    PVector get_vector(int x , int y){
        return ff[x+y*cols];
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
                angle = img[i]+random(0,1);
                v = PVector.fromAngle(angle);
                _ff[i] = v;
                //fill(color(original[i]));
                //print(original[i]);
                noStroke();
                rect(x*_scl, y * _scl,_scl,_scl);
                pushMatrix();
                translate(x*_scl, y * _scl);
                rotate(v.heading());
                
                //stroke(0,100); 
                
                line(0,0,scl,0);
                popMatrix();
            }
        }
        return _ff;
    }


}
    

    
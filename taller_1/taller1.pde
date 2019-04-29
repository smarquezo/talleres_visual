import processing.video.*;

PImage img; 
Movie video;
float[][] matrix = 

                     //{ { -1, -1, -1 },
                     //{ -1,  9, -1 },
                     //{ -1, -1, -1 } }; 
                     
                     //{ { 0, 0, 0 },
                     //{ 0,  1, 0 },
                     //{ 0, 0, 0 } }; 
                     
                       { { 1, 0, -1 },
                     { 0,  0, 0 },
                     { -1, 0, 1 } }; 
                     
                     //  { { 0, -1, 0 },
                     //{ -1,  5, -1 },
                     //{ 0, -1, 0 } }; 
                     
                     //  { { 0.0625, 0.125, 0.0625 },
                     //{ 0.125,  0.25, 0.125 },
                     //{ 0.0625, 0.125, 0.0625 } }; 
                     
int i_width= 400;
int i_heigth = 400;
int pos_i_x = 90, pos_i_y = 50;
int padding = 10;

color back = color(102, 102, 255);

boolean isVideo = false;

int[] hist;


void setup() {
  size(1000,600);
  
  background(back);
  
  if(!isVideo)
  {
  //load an image
  img = loadImage("assets/images/1.jpeg");  
  img.loadPixels();
  loadPixels();
  }
  else
  {
  //load a video
  video = new Movie(this, "4.mp4");
  video.loop();
  }
  
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

   int initial_w = pos_i_x + i_width + padding;
  int initial_h = pos_i_y;
  if(!isVideo)
  {
  image(img, pos_i_x, pos_i_y,i_width, i_heigth);
  image(img, pos_i_x + i_width + padding, pos_i_y,i_width, i_heigth);
  
  
  
  //luma(initial_w, initial_h);
  convolution(initial_w, initial_h);
  updatePixels();
  hist = histogram(initial_w, initial_h);
  
   stroke(255);
  for(int x = initial_w; x < i_width + initial_w; x += 2){
   int x1 = int(map(x, initial_w, i_width + initial_w, 0, 255));
   int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
   line(x, i_heigth + pos_i_y, x, y1);
    
  }
  loadPixels();
  
  }
  else
  {
  image(video, pos_i_x, pos_i_y,i_width, i_heigth);
  image(video, pos_i_x + i_width + padding, pos_i_y,i_width, i_heigth);
  //luma(initial_w, initial_h);
  convolution(initial_w, initial_h);
  updatePixels();
  }
  
  
  
}

void luma(int initial_w, int initial_h){
  
  loadPixels();
  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     color rgb = get(wi, hi);
     
     
     color greyscale = color(red(rgb) * 0.2126 + green(rgb) * 0.7152 + blue(rgb) * 0.0722);
     pixels[hi* 1000 + wi] = greyscale;
   }
     
  }
  updatePixels();
  
}

int[] histogram(int initial_w, int initial_h){
 
  loadPixels();
  int[] hist = new int[256];
  colorMode(HSB, 255);
  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     color rgb = get(wi, hi);
     int hist_value = int(brightness(rgb));
     hist[hist_value] += 1;
     
   }
     
  }
  
  return hist;
 
  
}




void convolution(int initial_w, int initial_h){
  
  loadPixels();
  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     
    
     color niu_color = getValue(wi,hi);
     pixels[hi* 1000 + wi] = niu_color;
   }
     
  }
  
  
}

color getValue(int x,int y){
  
  color result;
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  
  for(int wi = -1; wi <= 1; wi++){
   
    for(int hi = -1; hi <= 1; hi++){
      
      int new_x = x + wi, new_y = y + hi;
      color temp_color = get(new_x, new_y);
      
      if (temp_color != back){
        float val_mat = matrix[wi + 1][hi + 1];
        r += (red(temp_color) * val_mat);
        g += (green(temp_color) * val_mat);
        b += (blue(temp_color) * val_mat);
        }
      
    }
    
  }
  result = color(r,g,b);
  
  return result;
}

void mousePressed() {
  
  
}

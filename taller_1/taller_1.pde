import processing.video.*;

PImage img; 
PGraphics pg;

Movie video;
float[][] matrix_1 = 

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
                     
                     

float[][] matrix_2 = 
                    // { { -1, -1, -1 },
                    //  { -1,  9, -1 },
                    //  { -1, -1, -1 } }; 
                      { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0 } }; 

float[][] matrix_3 =
                    { { 0.0625, 0.125, 0.0625 },
                    { 0.125,  0.25, 0.125 },
                    { 0.0625, 0.125, 0.0625 } }; 

                     
int i_width= 250;
int i_heigth = 250;
int pos_i_x = 90, pos_i_y = 50;
int padding = 10;

int canvas_w = 1200, canvas_h = 650;

color back = color(102, 102, 255);

boolean isVideo ;

int init_histogram;
int finish_histogram;


int button_w = 150, button_h = 70;
String image_label = "Imagen", video_label = "Video";

int[] hist;


void setup() {
  size(1200, 500);
  background(back);
  PFont f = createFont("Arial", 30);
  
  
  //load an image
  img = loadImage("assets/images/2.jpg");  
  img.loadPixels();
  loadPixels();
  
  //load a video
  video = new Movie(this, "5.mp4");
  video.loop();

  //creating rectangles for buttons
  stroke(0);
  fill(0);
  rect(450, 350, button_w, button_h);
  rect(450 + button_w + padding, 350 , button_w, button_h);

  //creating buttons labels
  
  fill(255);
  textFont(f);
  text(image_label, 470, 390);
  text(video_label, 480 + button_w + padding, 390);
  
  
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

  //verify(mouseX, mouseY);

   int initial_w = pos_i_x + i_width + padding;
   int initial_w_2 = pos_i_x + i_width * 2+ padding * 2;
   int initial_w_3 = pos_i_x + i_width * 3+ padding * 3;
  int initial_h = pos_i_y;
  if(!isVideo)
  {
  image(img, pos_i_x, pos_i_y,i_width, i_heigth);
  image(img, pos_i_x + i_width + padding, pos_i_y,i_width, i_heigth);
  image(img, initial_w_2 , pos_i_y,i_width, i_heigth);
  image(img, initial_w_3, pos_i_y,i_width, i_heigth);
  
  
  
  luma(initial_w, initial_h);
  convolution(initial_w_2, initial_h, matrix_3);

  updatePixels();
  convolution(initial_w_3, initial_h, matrix_2);
  
  updatePixels();
  hist = histogram(initial_w, initial_h);

  

  
  
   stroke(255);
  for(int x = initial_w; x < i_width + initial_w; x += 2){
   int x1 = int(map(x, initial_w, i_width + initial_w, 0, 255));
   int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
   line(x, i_heigth + pos_i_y, x, y1);
    
  }


  hist = histogram(initial_w_2, initial_h);
 stroke(255);
  for(int x = initial_w_2; x < i_width + initial_w_2; x += 2){
   int x1 = int(map(x, initial_w_2, i_width + initial_w_2, 0, 255));
   int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
   line(x, i_heigth + pos_i_y, x, y1);
    
  }


  hist = histogram(initial_w_3, initial_h);
 stroke(255);
  for(int x = initial_w_3; x < i_width + initial_w_3; x += 2){
   int x1 = int(map(x, initial_w_3, i_width + initial_w_3, 0, 255));
   int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
   line(x, i_heigth + pos_i_y, x, y1);
    
  }

  loadPixels();
  
  }
  else if(isVideo)
  {
  image(video, pos_i_x, pos_i_y,i_width, i_heigth);
  image(video, pos_i_x + i_width + padding, pos_i_y,i_width, i_heigth);
  image(video, pos_i_x + i_width * 2 + padding * 2 , pos_i_y,i_width, i_heigth);
  image(video, pos_i_x + i_width * 3 + padding * 3 , pos_i_y,i_width, i_heigth);


  luma(initial_w, initial_h);
  convolution(pos_i_x + i_width * 2+ padding * 2, initial_h, matrix_3);

  updatePixels();
  convolution(pos_i_x + i_width * 3+ padding * 3, initial_h, matrix_2);
  
  updatePixels();

  println(frameCount);
  
  }
  
  
  
}

void luma(int initial_w, int initial_h){
  
  loadPixels();
  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     color rgb = get(wi, hi);
     
     
     color greyscale = color(red(rgb) * 0.2126 + green(rgb) * 0.7152 + blue(rgb) * 0.0722);
     pixels[hi* canvas_w + wi] = greyscale;
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




void convolution(int initial_w, int initial_h, float[][] matrix){
  
  loadPixels();
  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     
    
     color niu_color = getValue(wi,hi, matrix);
     pixels[hi* canvas_w + wi] = niu_color;
   }
     
  }
  
  
}

color getValue(int x,int y, float[][] matrix){
  
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


//function for see if rectagle has been pressed
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+ width && 
      mouseY >= y && mouseY <= y+ height) {
    return true;
  } else {
    return false;
  }
}


void mousePressed() {
  if(overRect(450, 350, button_w, button_h)){
    isVideo = false;
    
  }  
  if (overRect(450 + button_w + padding, 350, button_w, button_h)) {
    isVideo = true;
  }
  
  
}

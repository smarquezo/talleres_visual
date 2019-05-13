import processing.video.*;

PImage img; 
PGraphics pg;
PFont f;

HScrollbar bar1, bar2;


Movie video;
float[][] matrix_1 = 

                       { { 1, 0, -1 },
                     { 0,  0, 0 },
                     { -1, 0, 1 } }; 
                     
                    
                     

float[][] matrix_2 = 
                    
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
int fr= 60;

int canvas_w = 1200, canvas_h = 650;

color back = color(102, 102, 255);

boolean isVideo = false;

int init_histogram;
int finish_histogram;


int button_w = 150, button_h = 70;
String image_label = "Imagen", video_label = "Video";

int[] hist;


void setup() {
  size(1200, 500);
  background(back);
  f = createFont("Arial", 30);
  
  
  //load an image
  img = loadImage("assets/images/2.jpg");  
  img.loadPixels();
  loadPixels();
  
  //load a video
  video = new Movie(this, "4.mp4");
  video.loop();

  
  
  
  //Creating scrollbars, putting on position of luma image
  int aux = pos_i_x + i_width + padding;
   bar1 = new HScrollbar(pos_i_x + i_width + padding, pos_i_y + i_heigth + 10 ,i_width, 15 , 15 );
   bar2 = new HScrollbar(pos_i_x + i_width + padding, pos_i_y + i_heigth + 30 ,i_width, 15 , 15 );
  
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

  clear();

  background(back);

  //creating rectangles for buttons
  stroke(0);
  fill(255);
  rect(450, 350, button_w, button_h);
  rect(450 + button_w + padding, 350 , button_w, button_h);

  //creating buttons labels
  
  fill(0);
  textFont(f);
  text(image_label, 470, 390);
  text(video_label, 480 + button_w + padding, 390);


   int initial_w = pos_i_x + i_width + padding;
   int initial_w_2 = pos_i_x + i_width * 2+ padding * 2;
   int initial_w_3 = pos_i_x + i_width * 3+ padding * 3;
  int initial_h = pos_i_y;
  if(!isVideo)
  {


 
 loadPixels();

  image(img, pos_i_x, pos_i_y,i_width, i_heigth);
  image(img, pos_i_x + i_width + padding, pos_i_y,i_width, i_heigth);
  image(img, initial_w_2 , pos_i_y,i_width, i_heigth);
  image(img, initial_w_3, pos_i_y,i_width, i_heigth);
  
  
  
  luma(initial_w, initial_h);

  convolution(initial_w_2, initial_h, matrix_3);
  updatePixels();
  convolution(initial_w_3, initial_h, matrix_2);
  updatePixels();




  // hist = histo_segmentation(initial_w, initial_h);
//   hist = histogram(initial_w, initial_h);
//    stroke(255);
//   for(int x = initial_w; x < i_width + initial_w; x += 2){
//    int x1 = int(map(x, initial_w, i_width + initial_w, 0, 255));
//    int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
//    line(x, i_heigth + pos_i_y, x, y1);
    
//   }


//   hist = histogram(initial_w_2, initial_h);
//  stroke(255);
//   for(int x = initial_w_2; x < i_width + initial_w_2; x += 2){
//    int x1 = int(map(x, initial_w_2, i_width + initial_w_2, 0, 255));
//    int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
//    line(x, i_heigth + pos_i_y, x, y1);
    
//   }


//   hist = histogram(initial_w_3, initial_h);
//  stroke(255);
//   for(int x = initial_w_3; x < i_width + initial_w_3; x += 2){
//    int x1 = int(map(x, initial_w_3, i_width + initial_w_3, 0, 255));
//    int y1 = int(map(hist[x1], 0, max(hist), i_heigth, 0));
   
//    line(x, i_heigth + pos_i_y, x, y1);
    
//   }

  bar1.update();
  bar2.update();
  bar1.display();
  bar2.display();
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


  String frtxt = "Efficiency "+ frameRate/fr*100 + "%";
  text(frtxt, 90, 450);
  fill(back);
  

  //  background(back);
  
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

int[] histo_segmentation(int initial_w, int initial_h){

  loadPixels();

  float bar_pos_1 = bar1.getPos()- i_width/2;
  
  float bar_pos_2 = bar2.getPos()- i_width/2; 
  float min= map(bar_pos_1, pos_i_x + i_width + padding - 10, pos_i_x + i_width + padding + i_width + 10, 0, 255); 
  float max= map(bar_pos_2, pos_i_x + i_width + padding - 10, pos_i_x + i_width + padding + i_width + 10, 0, 255); 
  // println("min: "+min);
  // println("max: "+max);
  int[] hist = new int[256];

  for(int wi = initial_w; wi < i_width + initial_w; wi++) {
    
   for(int hi = initial_h; hi < i_heigth + initial_h; hi++){
     
     color rgb = get(wi, hi);
    //  println("rgb: "+rgb);
    //  color greyscale = color(red(rgb) * 0.2126 + green(rgb) * 0.7152 + blue(rgb) * 0.0722);

    float r = red (rgb); 
    float g = green(rgb);
    float b = blue(rgb); 

    float greyscale = r * 0.2126 + g * 0.7152 + b * 0.0722;

    r = constrain(greyscale, 0, 255);      
    g = constrain(greyscale, 0, 255);      
    b = constrain(greyscale, 0, 255);  

    color niu_color = color(r, g, b);  
    // println("niu_color: "+niu_color);
    if(greyscale>min && greyscale<max){
        pixels[hi* canvas_w + wi] = niu_color;
      }else{
        pixels[hi* canvas_w + wi] = 0; 
      }

      int hist_value = (int) greyscale;
     hist[hist_value] += 1;
     
   }
     
  }
  updatePixels();
  return hist;
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

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw; //<>//
    sheight = sh; //<>//
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) { //<>//
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv); //<>//
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth && //<>//
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke(); //<>//
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio; //<>//
  }
}

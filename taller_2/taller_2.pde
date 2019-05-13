int illusions = 7;
int actual = 1;

void setup(){
  size(600,600);
  frameRate(60);
}

void draw(){
  background(152);
  pushStyle();
  switch(actual){
    case 1:
      textSize(32);
      text("Taller 2", 240, 100);
      text("Ilusiones", 230, 150);
      text("Presentado por:", 180, 200);
      text("Santiago Pena", 190, 250);
      text("Camilo Mosquera", 170, 300);
      text("Santiago Marquez", 160, 350);
      break;
    case 2:      
      ScintillatingGrid();
      break;
    case 3:
      SteppingFeet();
      break;
    case 4:
      HeringIllusion();
      break;
    case 5:
      angles();
      break;
    case 6:
      sigma_motion();
      break;
    case 7:
      benhamIllusion();
      break;
  }
  popStyle();
}

//Switch illusion with left and rigth keys/////////////////////////////////
void keyPressed() {
  if(actual <= illusions && actual>=0){
    if (key == CODED) {
      if (keyCode == RIGHT) {
        actual+=1;
      } else if (keyCode == LEFT) {
        actual-=1;
      } 
    }
  }if (actual ==8) {
    actual=2;    
  }else if (actual ==0){
    actual=7;
  }
}

//Scintillating Grid illusion////////////////////////////////////////////
void ScintillatingGrid(){
  background(0);
   fill(255,0,0);
    noStroke();
    for(int i = 20; i < 600; i += 40){
            rect(i,0,7,600);
    }    
    for(int i = 20; i < 600; i += 40){
            rect(0,i,600,07);
    }
    for(int i = 20; i < 600; i += 40){
        for(int k = 20; k < 600; k += 40){
            fill(255);
            ellipse(i + 3,k + 3, 12,12);
        }        
    }
}

//Stepping Feet illusion vertical///////////////////////////////////////////////////
int wSquare = 130;
int ySquare = 120;
boolean positionSquare = false;

void SteppingFeet() {
  background(255);
  int step = 30;
  if (ySquare >= height - wSquare / 2) {
    positionSquare = true;
  }
  if (ySquare == wSquare / 2) {
    positionSquare = false;
  }
  if (!positionSquare) {
    ySquare++;
  }
  else {
    ySquare--;
  }

  strokeWeight(0);
  stroke(0, 0, 0);
  fill(0, 0, 0);
    for (int i = 0; i <= height; i = i + step) {
      rect(0, i * 2, width, step);
    }

  //Squares
  rectMode(CENTER);
  fill(0, 0, 102);
  noStroke();
  rect(200, ySquare, 70, 120);
  fill(255, 255, 0);
  noStroke();
  rect(400, ySquare, 70, 120);
}

//SteppingFeet horizontal/////////////////////////////////////////////////////////////

//int hSquare = 130;
//int xSquare = 120;
//boolean positionSquare = false;

//void SteppingFeet() {
//  background(255);
//  int step = 20;
//  if (xSquare >= width - hSquare / 2) {
//    positionSquare = true;
//  }
//  if (xSquare == hSquare / 2) {
//    positionSquare = false;
//  }
//  if (!positionSquare) {
//    xSquare++;
//  }
//  else {
//    xSquare--;
//  }

//  fill(0, 0, 0);
//  noStroke();
//    for (int i = 0; i <= height; i = i + step) {
//      rect( i * 2, 0, step, width);
//    }

//  //Squares
//  rectMode(CENTER);
//  fill(0, 0, 102);
//  noStroke();
//  rect(xSquare, 200, 130, 70);
//  fill(255, 255, 0);
//  noStroke();
//  rect(xSquare, 400, 130, 70);
//}


//Hering Illusion/////////////////////////////////////////////////////////////////

void HeringIllusion() {
  background(255);
  translate(300, 300);
  stroke(0, 0, 100);
  for (int i=0; i<490; i=i+10) {
    rotate(5);
    line(0, 0, 400, 400);
  }
  strokeWeight(3);
  stroke(200, 0, 0);
  rotate(-245);
  translate(-250, -250);
  line(200, 0, 200, 500);
  line(300, 0, 300, 500);
}

//Angles illusion/////////////////////////////////////////////////////////////////////

void angles() {
  //coloring
  noStroke();
  fill(175, 0, 175);
  quad(180, 170, 200, 200, 395, 200, 415, 170);
  quad(395, 200, 265, 375, 225, 375, 350, 200);
  fill(255, 0, 255);
  quad(350, 200, 225, 375, 225, 310, 302, 200);
  quad(120, 140, 100, 170, 225, 375, 225, 310);
  fill(100, 0, 100);
  quad(380, 140, 415, 170, 140, 170, 120, 140);
  quad(140, 170, 180, 170, 250, 275, 225, 310);
}


//Sigma motion //////////////////////////////////////////////////////////////////
int state=2000;
void sigma_motion(){
  int a =100;
  for(int x=0;x<a;++x){
    background(0);
  }
  
  for(int x=0;x<800/25;++x){
    int theme = ( (state%2 == 0 && x%2 == 0) || ( state%2 != 0 && x%2 == 1) ) ? 255 : 0; 
    fill(theme);
    stroke(theme);
    rect(25*x,0,100,800);
  }
  state = (state+1)%100;
}

//Benham Illusion //////////////////////////////////////////////////////////////////
void benhamIllusion(){
  
}
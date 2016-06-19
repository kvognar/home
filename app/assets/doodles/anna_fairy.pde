float naviX;
float naviY;

float tatlX;
float tatlY;

float taelX;
float taelY;

Fairy navi;
Fairy tatl;
Fairy tael;
Fairy[] fairies = new Fairy[7];

int cloudCount = 3;
float[] cloudX = new float[cloudCount];
float[] cloudY = new float[cloudCount];
float[] cloudSpeed = new float[cloudCount];

//int grassCount = 500;
//float[] grassX = new float[grassCount];
//float[] grassY = new float[grassCount];
//color[] grassColor = new color[grassCount];
//float[] xSize = new float[grassCount];
//float[] ySize = new float[grassCount];

void setup(){
  smooth();
  size(400,600);
  navi = new Fairy (100, 100, 1,1,0, 77, 1); //final argument is identity
  tatl = new Fairy (100, 50, 0,0,1, 77, 2);
  tael = new Fairy (100, 150, .5,1,0, 77, 3);
  for (int i = 0; i < 7; i ++){
    fairies[i] = new Fairy (200,290, 0,.8,0, (i*360/7), 0);
    
    cloudSetup();

//    grassSetup();

  }
}
void draw(){
  background(100,150,255);
  cloudMove();
  cloudDraw();
  plainGrass();
//  drawGrass();
  drawTriforce();
  for (int i = 0; i < 7; i++){
    fairies[i].drawFairy();
  }
  //heart1.drawFairy();
  navi.drawFairy();
  tatl.drawFairy();
  tael.drawFairy();
}
void cloudSetup(){ //initialize cloud arrays
  for(int i = 0; i < cloudCount; i ++){
    cloudX[i] = random(width);
    cloudY[i] = random(height/2);
    cloudSpeed[i] = random(0.1,0.5);
  }
}

void cloudDraw(){ //draws cloud ellipses
fill(255);
noStroke();
  for (int i = 0; i < cloudCount; i++){
   ellipse(cloudX[i], cloudY[i], 80,50);
   ellipse(cloudX[i] + 40, cloudY[i], 80, 50);
   ellipse(cloudX[i] - 40, cloudY[i], 80, 50);
   ellipse(cloudX[i] + 20, cloudY[i] - 25, 80, 50);
   ellipse(cloudX[i] - 20, cloudY[i] - 25, 80, 50);
  }
}

void cloudMove(){ //moves clouds across screen and repositions them if they leave
  for (int i = 0; i < cloudCount; i++){
  cloudX[i] = cloudX[i] - cloudSpeed[i];
   if (cloudX[i] < -80){
     cloudX[i] = width + 80;
     cloudY[i] = random(height/2);
     cloudSpeed[i] = random(0.1, 0.5);
   }
}
}
class Fairy {
  float x;
  float y;
  float xStart;
  float yStart;
  color glow;
  color wing;
  float rWing;
  float lWing;
  float time;
  float brWing;
  float blWing;
  float wingSpeed;
  float phase;
  
  float speedX;
  float speedY;
  float accelX;
  float accelY;
  
  float r;
  float g;
  float b;
  
  int name;
  
  int sparkCount = 10;
  float[] sparkX = new float[sparkCount];
  float[] sparkY = new float[sparkCount];
  
  
  Fairy(float x_, float y_, float r_, float g_, float b_, float phase_, int name_){
    xStart = x_;
    yStart = y_;
    r = r_;
    g = g_;
    b = b_;
    wing = color(100,100,255,100);
    rWing = 0;
    lWing = 0;
    brWing = 0;
    blWing = 0;
    time = random(360);
    wingSpeed = 30;
    name = name_;
    phase = phase_;
    
    for (int i = 0; i < sparkCount; i++){
      sparkX[i] = x;
      sparkY[i] = y;
    }
    
  }
  
  void drawFairy(){
    sparks();
    fairyMove();
    wings();
    body();
    fairyMath();
  }
  
  void body(){
    noFill();
    for(int i = 20; i > 0; i--){
      ellipse(x,y, i,i);
      stroke(255-10*i*r, 255-10*i*g, 255-10*i*b);
    }
  }
  void wings(){
    noStroke();
    fill(wing);
    
    pushMatrix();
    translate(x,y);
    rotate(rWing);
    ellipse(20,0,25,10);
    popMatrix();
    
    pushMatrix();
    translate(x,y);
    rotate(lWing);
    ellipse(20,0,25,10);
    popMatrix();
    
    pushMatrix();
    translate(x,y);
    rotate(brWing);
    ellipse(10,0,15,8);
    popMatrix();
    
    pushMatrix();
    translate(x,y);
    rotate(blWing);
    ellipse(10,0,15,8);
    popMatrix();
    
  }
  
  void fairyMath(){
  time ++;
  rWing = -(PI/4.0) + (PI/8)*sin(radians(time*wingSpeed));
  lWing = (5.0*PI/4.0) - (PI/8)*sin(radians(time*wingSpeed));
  brWing = (PI/4.0) - (PI/8)*sin(radians(time*wingSpeed));
  blWing = (3.0*PI/4.0) + (PI/8)*sin(radians(time*wingSpeed));
  }
  
  void fairyMove(){
    
    if (name == 1){ //navi's movement
      naviX = mouseX;
      naviY = mouseY;
      
      x = x + speedX;
      y = y + speedY;
      speedX = (speedX + accelX)*.95;
      speedY = (speedY + accelY)*.95;
      accelX = (naviX - x)/50;
      accelY = (naviY - y)/50;
      
      
      if (dist(x,y, naviX,naviY) < 30){
        speedX = speedX*.8;
        speedY = speedY*.8;
      }
    }
    else if (name == 2){ //tatl's movement
      if (dist(x,y, tatlX, tatlY) < 5){
       tatlX = random(20,width - 20);
       tatlY = random(20, height - 20); 
      }
      x = x + speedX;
      y = y + speedY;
      speedX = (speedX + accelX)*.95;
      speedY = (speedY + accelY)*.95;
      accelX = (tatlX - x)/50;
      accelY = (tatlY - y)/50;  
      
      speedX = constrain(speedX, -5, 5);
      speedY = constrain(speedY, -5, 5);
      
      taelX = x;
      taelY = y;
      
      if (dist(x,y, tatlX,tatlY) < 20){
        speedX = speedX*.8;
        speedY = speedY*.8;
      }
      
    }
    
    else if(name == 3){
      if (dist(x,y, taelX, taelY) < 5){
       tatlX = random(20,width - 20);
       tatlY = random(20, height - 20); 
      }
      x = x + speedX;
      y = y + speedY;
      speedX = (speedX + accelX)*.95;
      speedY = (speedY + accelY)*.95;
      accelX = (taelX - x)/50;
      accelY = (taelY - y)/50;  
      
      speedX = constrain(speedX, -5, 5);
      speedY = constrain(speedY, -5, 5);
    }
    
    else{
    x = xStart + 80*sin(radians(frameCount + phase));
    y = yStart + 40*cos(radians(frameCount + phase));
    }
  }
  
  
  void sparks(){
    if (name == 1){
      for (int i = 0; i < sparkCount-1; i++){
        sparkX[i] = sparkX[i+1];
        sparkY[i] = sparkY[i+1];
        strokeWeight(2);
        stroke(random(255),random(255),random(255));
        point(sparkX[i], sparkY[i]);
      }
      sparkX[sparkCount-1] = x;
      sparkY[sparkCount-1] = y;
    }
  }
}

 
    
//void grassSetup(){
//  for (int i = 0; i < grassCount; i ++){
//    grassX[i] = random(width);
//    grassY[i] = random(height/2, height);
//    grassColor[i] = color(random(50), random(150,255), random(50));
//    xSize[i] = random(30,50);
//  }
//}
//
//void drawGrass(){
//  noStroke();
//  for (int i = 0; i < grassCount; i++){
//    fill(grassColor[i]);
//    ellipse(grassX[i], grassY[i], xSize[i], xSize[i]);
//  }
//}

void plainGrass(){
  fill(25,200,50);
  noStroke();
  rect(0,400,width,height);
  fill(0,50);
  for(int d = 300; d > 40; d = d - 40){
    arc(200,400, d,d, 0, TWO_PI);
  }
}
color goldenPower = color(255,200,0);
float triX = 100;
float triY = 450;

void drawTriforce(){
  fill(goldenPower);
  noStroke();
  triangle(triX, triY, triX + 100, triY, triX + 50, triY - (86.6));
  triangle(triX + 100, triY, triX + 200, triY, triX + 150, triY - 86.6);
  triangle(triX + 50, triY - 86.6, triX + 150, triY - 86.6, triX + 100, triY - (86.6*2.0));
 
  goldenPower = color(255, 200+ 55*abs(sin(radians(frameCount))), 255*abs(sin(radians(frameCount))));
}


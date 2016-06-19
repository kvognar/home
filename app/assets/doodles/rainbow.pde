color red = color (255,0,0);
color orange = color (255,125,0);
color yellow = color (255,255,0);
color green = color (0,255,0);
color blue = color (0, 100, 255);
color purple = color (125, 0, 255);

int rainbowLength = 200;
float[]rainbowX = new float[rainbowLength];
float[]rainbowY = new float[rainbowLength];

float unicornX = 250;
float unicornY = 100;
float unicornV = 0;

float gravity = .1;
float ground = 250;
boolean jumping = true;
int jumpCount = 0;

int starCount = 250;
float time = 0;

int[] starsX = new int[starCount];
int[] starsY = new int[starCount];
int[] starSize = new int[starCount];
int[] starSpeed = new int[starCount];
int[] starStroke = new int[starCount];
//arrays and variables to generate stars

void setup(){
  size(600,400);
  for (int i = 0; i < rainbowLength; i++){
    rainbowX[i] = 0;
    rainbowY[i] = 0;
  }
    starSetup(); 

  smooth();
}

void draw(){
  background(255);
    stars();
  drawRainbow();
  unicorn();
  drive ();
  tardis();
  time = time + .1;
}

void drawRainbow(){
  noStroke();
  rainbowX[rainbowLength -1] = unicornX - 60;
  rainbowY[rainbowLength -1] = unicornY - 30;
for (int i = 0; i < rainbowLength -1; i++){
  rainbowX[i] = rainbowX[i+1] - 1;
  rainbowY[i] = rainbowY[i + 1];
  
  fill(red);
  rect(rainbowX[i], rainbowY[i], 10,10);
  fill(orange);
  rect(rainbowX[i], rainbowY[i] + 10, 10,10);
  fill(yellow);
  rect(rainbowX[i], rainbowY[i] + 20, 10,10);
  fill(green);
  rect(rainbowX[i], rainbowY[i] + 30, 10, 10);
  fill(blue);
  rect(rainbowX[i], rainbowY[i] + 40, 10, 10);
  fill(purple);
  rect(rainbowX[i], rainbowY[i] + 50, 10, 10);
}
}

void unicorn(){
  fill(100,100,255);
  //ellipse(unicornX, unicornY, 65,65);
  
  unicornY = unicornY + unicornV;
  unicornV = unicornV + gravity;
  
  if (unicornY > ground){
    unicornV = 0;
    unicornY = ground;
    jumping = false;
    jumpCount = 0;
  }
      
  
}

void keyPressed(){
  if(key == ' ' && jumpCount < 5){
    unicornV = -4;
    jumpCount ++;
  }

}

void starSetup(){ //Assign array of random values for star position, size and speed
  
   for (int i = 0; i < starsX.length; i ++){
      starsX[i] = int(random(width));
    }
      
    for (int i = 0; i < starsY.length; i ++){
      starsY[i] = int(random(height));
    }
    
    for (int i = 0; i < starSize.length; i ++){
      starSize[i] = int(random(4));
    }
    for (int i = 0; i < starSpeed.length; i ++){
      starSpeed[i] = int((random(1,4)));
    }
    for (int i = 0; i < starStroke.length; i ++){
      starStroke[i] = int(random(100,255));
    }
}



void stars(){ 
  //Draw starry background, and move stars to a new position
  //if they leave the screen
    background(0,0,50);
  stroke(255);
  for (int i = 0; i < starCount; i ++){
    starStroke[i] = int(noise(time + i)*255);
    stroke(starStroke[i]);
    strokeWeight(starSize[i]);
    point (starsX[i], starsY[i]);
   starsX[i] = starsX[i] - starSpeed[i];
    if (starsX[i] < 0){
      starsX[i] = width;
      starsY[i] = int(random(height));
    } 
  }
}
float X = 475;
float Y = 200;
color badWolf = color(50,75,150);
color lamp = (255);
float glow;



void tardis(){

  Y = 200 + 50*sin(radians(frameCount*2));
  
  rectMode(CENTER);
    stroke(0);
    strokeWeight(1);
    fill(lamp);
    rect(X, Y - 50, 5, 8);
    
  fill(badWolf);
  
  
  rect(X, Y - 43, 34, 6);
  rect(X, Y - 40, 40, 6);
  
  rect(X, Y, 50, 80); //big blue box
  
  rect(X - 10, Y + 14, 10, 12);
  rect(X + 10, Y + 14, 10, 12);
  rect(X - 10, Y + 29, 10, 12);
  rect(X + 10, Y + 29, 10, 12);
  rect(X + 10, Y - 1, 10, 12);
  rect(X - 10, Y - 1, 10, 12); //boxes
  
  fill(255);
  rect(X - 10, Y - 1, 6, 8); //free for use of public
  
  rect(X - 10, Y - 19, 10, 14);
  rect(X + 10, Y - 19, 10, 14);
  stroke(badWolf);
  line(X - 14, Y - 19, X - 6, Y - 19);
  line(X + 14, Y - 19, X + 6, Y - 19);
  line(X - 8, Y - 13, X - 8, Y - 25);
  line(X - 12, Y - 13, X - 12, Y - 25);
  line(X + 8, Y - 13, X + 8, Y - 25);
  line(X + 12, Y - 13, X + 12, Y - 25); //windows
  
  stroke(0);
  fill(0);
  rect(X, Y - 34, 40, 6);
  fill(255);
  rect(X, Y - 33, 30, 3);  //POLICE BOX
  
  fill(badWolf);
  rect(X, Y + 40, 55, 6);
  
  glow = 255*abs(sin(radians(frameCount)));
  lamp = color(glow, glow, 255);
  rectMode(CORNER);
}
void drive(){
  strokeWeight(1);
  rectMode(CENTER);
  fill(0,0,100);
  rect(unicornX,unicornY,130, 70);
  triangle(unicornX + 65, unicornY - 35, unicornX + 110, unicornY -4, unicornX + 65, unicornY - 4);
  quad(unicornX + 65, unicornY-18, unicornX + 161, unicornY + 10, unicornX + 161, unicornY + 35, unicornX+65, unicornY+35);
  
  fill(25,75,150);
  quad(unicornX + 60,unicornY - 32, unicornX+ 100,unicornY-4, unicornX + 35, unicornY-4, unicornX + 35, unicornY -32);
  rectMode(CORNER);
  rect(unicornX-10,unicornY-32,40,28);
  rect(unicornX-50,unicornY-32,36,28);
  
  fill(200,0,0);
  rect(unicornX-65,unicornY+10,6,5);
  fill(200,100,0);
  rect(unicornX-65,unicornY+15,6,5);
  
  fill(255*sin(time));
  rect(unicornX+155,unicornY+15,6,8);
  
  //51x31

  tires(unicornX-30,unicornY+35);
  tires(unicornX+120,unicornY+35);
}

void tires(float tireX,float tireY){
  noStroke();
  fill(50);
  ellipse(tireX,tireY,40,40);
  fill(150);
  ellipse(tireX,tireY,30,30);
  
  for (float i = 0; i < 7; i ++){
    pushMatrix();
    translate(tireX,tireY);
    rotate((radians(time + i*360/7.0))*60);
    strokeWeight(1);
    stroke(0);
    point(5,0);
    fill(0);
    triangle(8,0, 12,-2, 12,2);
    popMatrix();
  }
}
  


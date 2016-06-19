color brella = color(0,0,50);
color sky = color(100,100,120);
color water = color(0);
int windFactor = -1;
float umbrellaHeight = 230;
float dandyX = 200;
float dandyY = 500;
float dandyR = 20;
float dandyGX = 200;
float dandyGY = 550;



int rainCount = 1000;
int[] rainX= new int[rainCount];
int[] rainY = new int[rainCount];


void setup(){
  size(400,600);
    rainSetup();
  smooth();
}

void draw(){
  background(sky);
  umbrella();
  rain();
  dandelion();
}

void umbrella(){
 noStroke();
 fill(brella);
 
 arc(200,250,200,150,PI,TWO_PI);
 
 fill(sky);
 arc(125,250,50,20,PI,TWO_PI);
 arc(175,250,50,20,PI,TWO_PI);
 arc(225,250,50,20,PI,TWO_PI);
 arc(275,250,50,20,PI,TWO_PI);
 
 stroke(brella);
 strokeWeight(6);
 line(200,240,200,380);
 noFill();
 arc(185,380,30,30,0,PI);

}

void rainSetup(){
  for (int i = 1; i < rainCount; i++){
    rainX[i] = int(random(width + 100));
    rainY[i] = int(random(-600, 0));
  }
}

void rain(){
  strokeWeight(1);
  stroke(brella);
  for (int i = 1; i < rainCount; i++){
    line (rainX[i], rainY[i], rainX[i] + windFactor, rainY[i] + 5);
    
    rainY[i] = rainY[i] + 8;
    rainX[i] = rainX[i] + windFactor;
    
    if (rainY[i] > height + 20 || (rainY[i] > umbrellaHeight && rainY[i] < umbrellaHeight + 20 && rainX[i] > 100 && rainX[i] < 300)){
      rainY[i] = 0;
      rainX[i] = int(random(width + abs((height * windFactor))));
    }
  }
}

void dandelion(){
  
  stroke(0,150,0);
  strokeWeight(4);
  line(dandyX, dandyY, dandyGX, dandyGY);

  stroke(255);
  strokeWeight(2);
  point(dandyX, dandyY);
  for (float i = 0; i < 36; i++){
  line(dandyX, dandyY, dandyX + dandyR*cos(i*TWO_PI/36), dandyY + dandyR*sin(i*TWO_PI/36));
  }
  
  dandyX = 200 + 10*cos(radians(frameCount));
}
  


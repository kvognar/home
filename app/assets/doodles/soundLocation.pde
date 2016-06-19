Wave sound = new Wave();
Ear lefty = new Ear(200,300);
Ear righty = new Ear(600,300);


Track[] tracksR = {new Track(righty.x, righty.y, 600, 250),
                  new Track(600, 250, 249, 250),
                  new Track(550, 250, 550, 300),
                  new Track(500, 250, 500, 300),
                  new Track(450, 250, 450, 300),
                  new Track(400, 250, 400, 300),
                  new Track(350, 250, 350, 300),
                  new Track(300, 250, 300, 300),
                  new Track(250, 250, 250, 300)};

Track[] tracksL = {new Track(lefty.x, lefty.y, lefty.x, 350),
                  new Track(200, 350, 551, 350),
                  new Track(250, 350, 250, 300),
                  new Track(300, 350, 300, 300),
                  new Track(350, 350, 350, 300),
                  new Track(400, 350, 400, 300),
                  new Track(450, 350, 450, 300),
                  new Track(500, 350, 500, 300),
                  new Track(550, 350, 550, 300)};

Detector[] nodes = {new Detector(250, 300),
                    new Detector(300, 300),
                    new Detector(350, 300),
                    new Detector(400, 300),
                    new Detector(450, 300),
                    new Detector(500, 300),
                    new Detector(550, 300)};

void setup(){
  size(800,600);
  //tracksL[0].initiate();
  
}

void draw(){
  background(255);
  sound.display();
  
  nodeThings();
  
  lefty.listen();
  righty.listen();
  
  lefty.display();
  righty.display();
    
  neurons();

  speak();
  
  pinpoint(getSound());
}

void mousePressed(){
  
  for (int i = 0; i < nodes.length; i++){
    nodes[i].reset();
  }
  
  if (sound.vis == false){
    sound.vis = true;
    sound.x = mouseX;
    sound.y = mouseY;
  }
  else{
    sound.vis = false;
    sound.rad = 0;
  }
}

void neurons(){
  for (int i = 0; i < tracksL.length; i++){
    tracksL[i].display();
    tracksL[i].spark();
  }
  
  for (int i = 0; i < tracksR.length; i++){
    tracksR[i].display();
    tracksR[i].spark();
  }
  
  sparkCheck(tracksL);
  sparkCheck(tracksR);
}
class Detector{
  float x;
  float y;
  float timer = 25;
  float timeStart = 25;
  
  color off = color(0,0,0);
  color mid = color(255,255,0);
  color on = color(255,0,0);
  
  boolean hit1 = false;
  boolean hit2 = false;
  
  Detector(int x_, int y_){
    x = x_;
    y = y_;
  }
  
  void display(){
    noStroke();
    if(hit1 == false){
      fill(off);
      ellipse(x, y, 10, 10);
    }
    else if(hit1 == true && hit2 == false){
      fill(mid);
      ellipse(x, y, timer, timer);
    }
    else if(hit2 == true){
      fill(on);
      ellipse(x, y, 20, 20);
    }
  }
  
  boolean listen(){
    for (int i = 0; i < tracksL.length; i++){
      if (tracksL[i].sparkX == x && tracksL[i].sparkY == y){
        tracksL[i].reset();
        return true;
      }
      
      if (tracksR[i].sparkX == x && tracksR[i].sparkY == y){
        tracksR[i].reset();
        return true;
      }
      
    }
    return false;
  }
  
  void coin(){
    if (hit1 == false && listen()){
      hit1 = true;
      timer = timeStart;
    }
    else if (hit1 == true && hit2 == false){
      timer -= 0.5;
      if (listen()){
        hit2 = true;
      }
      else if (timer <= 0){
      hit1 = false;
     }
    }
    
   }
   
   void reset(){
     hit1 = false;
     hit2 = false;
   }
      
      
}

void nodeThings(){
  for (int i = 0; i < nodes.length; i++){
    nodes[i].display();
    nodes[i].coin();
  }
}
class Ear{
  float x;
  float y;
  boolean hear;
  
  color on = color(255,0,0);
  color off = color(0,0,255);
  float rad = 7;
  
  Ear(float x_, float y_){
    x = x_;
    y = y_;
    hear = false;
  }
  
  void display(){
    noStroke();
    if(hear){
      fill(on);
    }
    else fill(off);
    
    ellipse(x, y, rad*2, rad*2);
  }
  
  void listen(){
    if (abs(dist(x, y, sound.x, sound.y) - sound.rad) < rad && hear == false){
      hear = true;
    }
    else if (abs(dist(x, y, sound.x, sound.y) - sound.rad) > rad){
      hear = false;
    }
    
    
    
    }
}

void speak(){
  if (lefty.hear && tracksL[0].sparking == false){
    tracksL[0].initiate();
  }
  if (righty.hear && tracksR[0].sparking == false){
    tracksR[0].initiate();
  }
}
  
int getSound(){
    for (int i = 0; i < nodes.length; i ++){
      if (nodes[i].hit2 == true){
        return i;
      }
    }
    return -1;
}

void pinpoint(int i){
 if(i == -1){
  return;
 }
  noStroke();
  fill(100,100,255,100);
  
  if(i == 0){
   arc(400, 300, 1000, 1000, -PI/12, PI/12);
  } 
  
  else if (i == 1){
    arc(400, 300, 1000, 1000, -3*PI/12, -PI/12);
    arc(400, 300, 1000, 1000, PI/12, 3*PI/12);
  }
  
  else if (i == 2){
    arc(400, 300, 1000, 1000, -5*PI/12, -3*PI/12);
    arc(400, 300, 1000, 1000, 3*PI/12, 5*PI/12);
  }
  
  else if (i == 3){
    arc(400, 300, 1000, 1000, -7*PI/12, -5*PI/12);
    arc(400, 300, 1000, 1000, 5*PI/12, 7*PI/12);
  }
  
  else if (i == 4){
    arc(400, 300, 1000, 1000, -9*PI/12, -7*PI/12);
    arc(400, 300, 1000, 1000, 7*PI/12, 9*PI/12);
  }
  
  else if (i == 5){
    arc(400, 300, 1000, 1000, -11*PI/12, -9*PI/12);
    arc(400, 300, 1000, 1000, 9*PI/12, 11*PI/12);
  }
  
  else if (i == 6){
    arc(400, 300, 1000, 1000, 11*PI/12, 13*PI/12);
  }
  
    
}
class Track{
  float sx;
  float sy;
  float fx;
  float fy;
  float dx;
  float dy;
  float sparkX;
  float sparkY;
  float sparkR;
  
  int start;
  int stop;
  
  boolean sparking = false;
  
  Track(float sx_, float sy_, float fx_, float fy_){
    sx = sx_;
    sy = sy_;
    fx = fx_;
    fy = fy_;
    if(abs(fx_-sx_) != 0){
      dx = (fx_-sx_)/abs(fx_-sx_);
    }
    else{
      dx = 0;
    }
    if(abs(fy_-sy_) != 0){
      dy = (fy_-sy_)/abs(fy_-sy_);
    }
    else{
      dy = 0;
    }
  }
  
  void display(){
    stroke(0);
    strokeWeight(1);
    line(sx, sy, fx, fy);
  }
  
  void spark(){
    if(sparking){
      sparkX += dx;
      sparkY += dy;
      
      noStroke();
      fill(255,255,0);
      ellipse(sparkX, sparkY, 8, 8);
      
      if(sparkX == fx && sparkY == fy){
        sparking = false;
      }
    }
  }
  
  void initiate(){
    sparking = true;
    sparkX = sx;
    sparkY = sy;
  }
  
  void reset(){
    sparking = false;
    sparkX = 0;
    sparkY = 0;
  }
}

void sparkCheck(Track[] rails){
  for (int i = 0; i < rails.length; i++){
    for (int j = 0; j < rails.length; j++){
      if (i != j){
        if (rails[j].sparkX == rails[i].sx && rails[j].sparkY == rails[i].sy){
          rails[i].initiate();
          if (rails[j].sparkX == rails[j].fx && rails[j].sparkY == rails[i].fy){
            rails[j].sparkX = 0;
            rails[j].sparkY = 0;
          }
        }
      }
    }
  }
}

class Spark {
  float x;
  float y;
  float rad;
  
  Track rail;
  
  Spark(Track rail_){
    rail = rail_;
    x = rail.sx;
    y = rail.sy;
    rad = 10;
  }
  
  void flow(){
    x = x + rail.dx;
    y = y + rail.dy;
    
    if(x == rail.fx && y == rail.fy){
      jump();
    }
  }
  
  void display(){
    noStroke();
    fill(255,255,0);
    ellipse(x, y, rad/2, rad/2);
  }
  
  void jump(){
  }
  
}
class Wave {
  float x;
  float y;
  float rad;
  boolean vis;
  
  Wave(){
    x = 0;
    y = 0;
    rad = 0;
    vis = false;
  }
  
  void grow(){
    rad += 1.5;
  }
  
  void display(){
    if(vis){
      strokeWeight(1);
      stroke(0);
      noFill();
      ellipse(x, y, rad*2, rad*2);
      noStroke();
      fill(0,200,0);
      ellipse(x, y, 15, 15);
      grow();
    }
  }
  
  
}


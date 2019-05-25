Pad pad;
Ball ball;
ArrayList<Brick> level;
char[][] layout = {
   {'*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'},
   {'*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'},
   {'*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'},
   {'*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*', '*'}
};

int brokenBrick = -1;

byte collision(){
  if(ball.pos.x <= 0 || ball.pos.x >= width) return 1;
  if(ball.pos.y <= 0) return 2;
  if(ball.pos.y > height) return -1;
  if(ball.pos.x >= pad.pos.x && ball.pos.x <= pad.pos.x + pad.pWidth && ball.pos.y >= pad.pos.y && ball.pos.y <= pad.pos.y + 0.5f) return 3;
  for(Brick b : level){
    if(ball.pos.x >= b.pos.x && ball.pos.x <= b.pos.x + b.bWidth &&
       ball.pos.y >= b.pos.y && ball.pos.y <= b.pos.y + b.bHeight){
         if(ball.pos.y > b.pos.y && ball.pos.y < b.pos.y + b.bHeight) {
           brokenBrick = level.indexOf(b);
           return 4;
         }
         else if(ball.pos.x > b.pos.x && ball.pos.x < b.pos.x + b.bWidth) {
           brokenBrick = level.indexOf(b);
           return 5;
         }
       }
  }
  return 0;
}

void loadLevel(char[][] _layout){
  level.clear();
  for(int i = 0; i < 4; i++){
   for(int j = 0; j < 12; j++){
    if(_layout[i][j] == '*') level.add(new Brick(new PVector(j, i)));
   }
  }
}

void setup(){
  pad = new Pad();
  ball = new Ball();
  level = new ArrayList<Brick>();
  loadLevel(layout);
  size(800, 600);
}


void draw(){
  background(80);
  fill(255);
  frameRate(30);
  
  int dir = keyPressed && key == 'a' ? -1 : keyPressed && key == 'd' ? 1 : 0; 
  
  byte collision = collision();
  
  if(collision == -1){
    ball = new Ball();
    loadLevel(layout);
    brokenBrick = -1;
  }
  else if(collision == 4 || collision == 5){
    if(brokenBrick != -1){
      level.remove(brokenBrick); 
    }
    
    if(level.size() == 0 ) loadLevel(layout);
  }
  
  pad.update(dir);
  ball.update(collision);
  pad.show();
  ball.show();
  for(Brick b : level) b.show();
}

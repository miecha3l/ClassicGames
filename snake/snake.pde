PVector snakeHead;
PVector apple;
ArrayList<PVector> snakeBody;
int len;
PVector[] move;
final int UP = 0;
final int DOWN = 1;
final int LEFT = 2;
final int RIGHT = 3;
int currentDir;
final int tick = 100;
int tickspeed = 15;
int currentTick;
PVector temp = new PVector();
final int tile = 40;
int tilesW;
int tilesH;




void initSnake(int length){
    len = length;
    snakeHead = new PVector(5, 6);
    snakeBody = new ArrayList<PVector>();
    for(int i = 1; i < 4; i++) snakeBody.add(new PVector(snakeHead.x - i, snakeHead.y));
    currentTick = 0;
}

void gameOver(){
   snakeBody.clear();
   snakeHead = new PVector(5, 6);
   currentDir = RIGHT;
   initSnake(3);
}

void eat(){
    snakeBody.add(0, new PVector(snakeHead.x, snakeHead.y));
    snakeHead.add(move[currentDir]);
    apple.x = (int)(random(tilesW - 2) + 1);
    apple.y = (int)(random(tilesH - 2) + 1);
}

void setup(){
   size(800, 800);
   initSnake(3); 
   move = new PVector[4];
   move[UP] = new PVector(0, -1);
   move[DOWN] = new PVector(0, 1);
   move[LEFT] = new PVector(-1, 0);
   move[RIGHT] = new PVector(1, 0);
   currentDir = RIGHT;
   currentTick = 0;
   tilesW = width/tile;
   tilesH = height/tile;
   apple = new PVector((int)(random(tilesW - 2) + 1), (int)(random(tilesH - 2) + 1));
}

void draw(){
  background(50);  
  frameRate(30);
  
  currentTick += tickspeed;
  
  if(keyPressed){
    switch(key){
      case 'w': if(currentDir != DOWN) currentDir = UP; break;
      case 's': if(currentDir != UP) currentDir = DOWN; break;
      case 'a': if(currentDir != RIGHT) currentDir = LEFT; break;
      case 'd': if(currentDir != LEFT) currentDir = RIGHT; break;
    }
  }
  
  
  if(snakeHead.x < 0 || snakeHead.x > tilesW || snakeHead.y < 0 || snakeHead.y > tilesH) gameOver();
  boolean gameOver = false;
  for(PVector part : snakeBody) if(snakeHead.x == part.x && snakeHead.y == part.y) {gameOver = true; break;}  
  if(gameOver) gameOver();
  if(snakeHead.x == apple.x && snakeHead.y == apple.y) eat();
  
  
  fill(255, 255, 255);
  rect(snakeHead.x * tile, snakeHead.y * tile, tile, tile);
  for(PVector part : snakeBody){
    rect(part.x * tile, part.y * tile, tile, tile);
  }
  
  fill(255, 0, 0);
  rect(apple.x * tile, apple.y * tile, tile, tile);
  
  if(currentTick >= tick){    
    snakeBody.add(0, new PVector(snakeHead.x, snakeHead.y)); //<>//
    snakeBody.remove(snakeBody.size() - 1);
    snakeHead.add(move[currentDir]);
    currentTick = 0;
  }
}

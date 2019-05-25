final char block[][] = {
  {' ', ' ', ' ', ' '},
  {' ', '*', '*', ' '},
  {' ', '*', '*', ' '},
  {' ', ' ', ' ', ' '}
};

final char blockT[][] = {
  {' ', ' ', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', '*', ' '},
  {' ', '*', ' ', ' '}
};

final char blockI[][] = {
  {' ', '*', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', ' ', ' '}
};

final char blockL[][] = {
  {' ', ' ', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', '*', ' '}
};

final char blockLL[][] = {
  {' ', ' ', ' ', ' '},
  {' ', ' ', '*', ' '},
  {' ', ' ', '*', ' '},
  {' ', '*', '*', ' '}
};

final char blockS[][] = {
  {' ', ' ', ' ', ' '},
  {' ', '*', ' ', ' '},
  {' ', '*', '*', ' '},
  {' ', ' ', '*', ' '}
};

final char blockZ[][] = {
  {' ', ' ', ' ', ' '},
  {' ', ' ', '*', ' '},
  {' ', '*', '*', ' '},
  {' ', '*', ' ', ' '}
};

ArrayList<PVector> stack;
Tetrimino active;
final PVector gridSize = new PVector(30, 30);
final int tickLen = 120;
int tickrate = 8;
int currentTick = 0;
final PVector wellSize = new PVector(10, 20);
int score;

void drawGrid(){
 for(int i = 0; i < wellSize.y; i++){
  for(int j = 0; j < wellSize.x; j++){
   fill(0,0,0,0);
   stroke(0,0,0, 50);
   rect(j * gridSize.x, i * gridSize.y, gridSize.x, gridSize.y);
  }
 }
}

void drawStack(){
 for(PVector b : stack) {
   fill(#5A39B7);
   noStroke();
   rect(b.x * gridSize.x, b.y * gridSize.y, gridSize.x, gridSize.y);
 }
}

boolean checkRows(){
 int inRow = 0;
 IntList rowsToRemove = new IntList();
 int x, y;
 
 for(PVector b : stack) if(b.y <= 0) return false;
 
 for(y = (int)wellSize.y - 1; y > 0; y--){
  for(x = 0; x < wellSize.x; x++){
   if(stack.indexOf(new PVector(x, y))  == -1) break;
   else inRow+=1;
  }  
  if(inRow == wellSize.x) rowsToRemove.append(y);
  inRow = 0;
 }
 
 if(rowsToRemove.size() > 0){
  for(int _y : rowsToRemove){
    for(int i = 0; i < stack.size();){
     if(stack.get(i).y == _y) stack.remove(i);
     else i++;
   }
   score += 100 * rowsToRemove.size();
  }
 
  rowsToRemove.sort();
  for(y = rowsToRemove.get(0) - 1; y > 0; y--){
   for(x = 0; x < wellSize.x; x++){
     if(stack.indexOf(new PVector(x, y)) != -1){
       stack.get(stack.indexOf(new PVector(x, y))).y += rowsToRemove.size();
    }
   }
  }
 }
 
 return true;
}


void keyReleased(){
  if(key == 'w') active.rotate();
}


void setup(){
  size(300, 630);
  active = new Tetrimino(gridSize);
  stack = new ArrayList<PVector>();
  frameRate(30);
}

void draw(){  
  currentTick += tickrate;
  background(200);
  
  boolean speed = keyPressed && key == 's' ? true : false;
  if(keyPressed && key == 'a') active.move(-1);
  if(keyPressed && key == 'd') active.move(1);
  
  
  drawStack();
  active.show();
  drawGrid();
  textSize(16);
  fill(80);
  text("Score: " + score, 125, 620);
  noFill();
  if(!active.update(speed)) active = new Tetrimino(gridSize);
  
  if(!checkRows()) {
    stack.clear();
    active = new Tetrimino(gridSize);
    score = 0;
  }
}

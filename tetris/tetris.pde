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

/////////////////////////////////////////////////////////////////////////////////////////

class Tetrimino{
 char[][] variant;
 PVector dim;
 PVector globalPos;
 ArrayList<PVector> piecesPos;
 color col;
 
 Tetrimino(PVector _dim){
   variant = new char[4][4];
   int rand = (int)random(7);
   for(int i = 0; i < 4; i++){
     for(int j = 0; j < 4; j++){
      switch(rand){
       case 0: variant[j][i] = block[j][i]; break;
       case 1: variant[j][i] = blockI[j][i]; break;
       case 2: variant[j][i] = blockT[j][i]; break;
       case 3: variant[j][i] = blockS[j][i]; break;
       case 4: variant[j][i] = blockL[j][i]; break;
       case 5: variant[j][i] = blockLL[j][i]; break;
       case 6: variant[j][i] = blockZ[j][i]; break;
      }
     }
   }
   dim = _dim;
   globalPos = new PVector((int)random(4,7), -1);
   piecesPos = new ArrayList<PVector>();
   col = #5A39B7;
   
   for(int i = 0; i < 4; i++){
     for(int j = 0; j < 4; j++){
       if(variant[i][j] == '*') piecesPos.add(new PVector(i + globalPos.x, j + globalPos.y));   
     }
   }   
 }
 
 void rotate(){
   int n = 4;
   char[][] ret = new char[n][n];
   for(int i = 0; i < n; i++){
     for(int j = 0; j < n; j++){
       ret[i][j] = variant[n - j - 1][i];
     }
   }
   
   for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
     for(PVector b : stack){
      if(ret[j][i] == '*' && (j + globalPos.x == b.x && i + globalPos.y == b.y)) return; 
     }
     
     if(ret[j][i] == '*' && (j + globalPos.x >= wellSize.x - 1 || j + globalPos.x <= 0 || i + globalPos.y >= wellSize.y - 1 || i + globalPos.y < 0)) return;
    }
   }
   variant = ret;
 }
 
 void move(int dir){
  boolean good = true;  
  for(PVector piece : active.piecesPos){        
    for(PVector b : stack){
     if(piece.x + dir == b.x && piece.y == b.y) good = false;
    }   
    if(piece.x + dir >= wellSize.x || piece.x + dir < 0) good = false;
   }   
   if(good && currentTick % 16 == 0) active.globalPos.x += dir;
 }
 
 boolean update(boolean speed){    
   //every tick || every frame
   if(currentTick == tickLen || speed){
     boolean good = true;
     for(PVector piece : piecesPos){
      for(PVector b : stack) if(piece.x == b.x && piece.y + 1 == b.y) good = false;
      if(!(piece.y + 1 < wellSize.y)) good = false; 
     }
     if(good) globalPos.y += 1;
     else{
      for(PVector piece : piecesPos) stack.add(new PVector(piece.x, piece.y));
      currentTick = 0;
      return false;
     }
     currentTick = 0;
   }
   
   return true;
 }
 
 
 
 void show(){
   int pieceIndex = 0;
   for(int i = 0; i < 4; i++){
     for(int j = 0; j < 4; j++){
       if(variant[i][j] == '*') piecesPos.set(pieceIndex++, new PVector(i + globalPos.x, j + globalPos.y));   
     }
   }
   
   fill(col);
   noStroke();
   for(PVector piece : piecesPos) rect(dim.x * piece.x, dim.y * piece.y, dim.x, dim.y);
 }
 
 
 
}

//////////////////////////////////////////////////////////////////////////////////////////////////



ArrayList<PVector> stack;
Tetrimino active;
final PVector gridSize = new PVector(30, 30);
final int tickLen = 120;
int tickrate = 8;
int currentTick = 0;
final PVector wellSize = new PVector(10, 20);

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
  size(300, 600);
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
  if(!active.update(speed)) active = new Tetrimino(gridSize);
  
  if(!checkRows()) {
    stack.clear();
    active = new Tetrimino(gridSize);
  }
}

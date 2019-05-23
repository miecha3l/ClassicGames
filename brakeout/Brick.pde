class Brick{
  PVector pos;
  float bWidth, bHeight;
  
  Brick(PVector levelPos){
     bWidth = 50.0f;
     bHeight = 50.0f;
     pos = new PVector(levelPos.x * bWidth + 200, levelPos.y * bHeight + 50);
  }
  
  void show(){
    rect(pos.x, pos.y, bWidth, bHeight); 
  }
}

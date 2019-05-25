class Brick{
  PVector pos;
  float bWidth, bHeight;
  color col;
  
  Brick(PVector levelPos){
     color[] colors = {#F21818, #4A18F2, #D315D3, #2E8E0E, #EDCA1A, #DE9216};
     bWidth = 50.0f;
     bHeight = 50.0f;
     pos = new PVector(levelPos.x * bWidth + 99.5f, levelPos.y * bHeight + 50);
     col = colors[(int)random(6)];
  }
  
  void show(){
    fill(col);
    rect(pos.x, pos.y, bWidth, bHeight);
    noFill();
  }
}

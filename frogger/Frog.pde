class Frog{
  PVector gridPos;
  float size;
  color col;
  
  private PVector gridToWorld(PVector gridp){
    return new PVector(gridp.x * 25 + 2.5f, gridp.y * 25 + 2.5f);
  }
  
  Frog(){
    gridPos = new PVector(16, 23);
    size = 20.0f;
    col = #10E81C;
  }
  
  void update(PVector move){
    if(!(gridPos.x + move.x > 31 || gridPos.x + move.x < 0 || gridPos.y + move.y > 23)){
      gridPos.add(move);
    }
  }
  
  void show(){
    PVector worldPos = gridToWorld(gridPos);
    fill(col);
    noStroke();
    rect(worldPos.x, worldPos.y, size, size);
    noFill();
    stroke(0);
  }
}

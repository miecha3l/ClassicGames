class Car{
  PVector gridPos;
  float size;
  int len;
  PVector dir;
  color col;
  
  private PVector gridToWorld(PVector gridp){
    return new PVector(gridp.x * 25 + 2.5f, gridp.y * 25 + 2.5f);
  }
  
  Car(int _len, int y){
    int x = parseBoolean((int)random(2)) ? 1 : -1;
    dir = new PVector(x, 0);
    gridPos = new PVector(x > 0 ? 0 : 31, y);
    col = (int)random(2) == 0 ? #C11F1F : #4443B7;
    size = 20.0f;
    len = _len;
  }
  
  void update(){
    gridPos.add(dir);
  }
  
  void show(){
    PVector worldPos = gridToWorld(gridPos);
    fill(col);
    noStroke();
    for(int i = 1; i < len; i++) {
      PVector newGPos = new PVector(gridPos.x - (i * dir.x), gridPos.y); 
      PVector pos = gridToWorld(newGPos);
      rect(pos.x, pos.y, size, size);
    }
    rect(worldPos.x, worldPos.y, size, size);
    noFill();
    stroke(0);
  }
}

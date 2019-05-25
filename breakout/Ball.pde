class Ball{
  PVector pos;
  float radius;
  PVector velocity;
  float speed = 10.0f;
  
  Ball(){
    pos = new PVector(width/2 - radius/2, height/2);
    radius = 10;
    int dir = parseBoolean((int)random(2)) ? 1 : -1;
    velocity = new PVector(1 * dir, 1);
    velocity.mult(speed);
  }
  
  void update(byte collisionType){
    
    switch(collisionType){
      case 0: break;
      
      case 1:
      case 4:
        velocity.x = -velocity.x;
        break;
      
      case 2:
      case 3:      
      case 5:
        velocity.y = -velocity.y;
        break;
        
    }
    
    pos.add(velocity);
  }
  
  void show(){
    ellipse(pos.x, pos.y, radius, radius); 
  }
  
}

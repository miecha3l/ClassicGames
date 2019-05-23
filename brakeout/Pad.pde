class Pad{
 PVector pos;
 float pWidth, pHeight;
 float speed;
 
 Pad(){
   pWidth = 100;
   pHeight = 10;
   speed = 10;
   pos = new PVector(width/2 - (pWidth/2), height - 50); 
 }
 
 void update(int input){
   pos.add(new PVector(input * speed, 0)); 
 }
 
 void show(){
   rect(pos.x, pos.y, pWidth, pHeight); 
 }
}

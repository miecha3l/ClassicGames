float gridWidth = 32, gridHeight = 24;
float tileSize = 25;
final int ticklen = 100;
int tickrate = 25;
int currentTick = 0;
Frog frog;
ArrayList<Car> cars;
String[] map;
int score = 0;
int carsToSpawn = 2;

int[] protectedY = {0, 1, 6, 11, 12, 17, 22, 23};

void drawMap(){
  noStroke();
  for(int i = 0; i < gridHeight; i++){
    for(int j = 0; j < gridWidth; j++){
      int tile = map[i].charAt(j) - '0';
      switch(tile){
        case 1: fill(#607147); break;
        case 2: fill(#343232); break; 
        case 3: fill(#E5E5E5); break; 
      }
      rect(j * tileSize, i * tileSize, tileSize, tileSize); 
    }
  }
  noFill();
}

//moving cars & collision checks
boolean updateCars(){
  outer:
  for(int i = 0; i < cars.size(); i++){
    cars.get(i).update();
    for(int j = 0; j < cars.get(i).len; j++){
      
      //collision with frog
      if(frog.gridPos.x == cars.get(i).gridPos.x - (j * cars.get(i).dir.x) && frog.gridPos.y == cars.get(i).gridPos.y) return false;
      
      //removing cars that drove out of map
      if(cars.get(i).dir.x < 0){
        if(cars.get(i).gridPos.x < 0) {
          cars.remove(cars.get(i));
          continue outer;
        }
      }
      else{
        if(cars.get(i).gridPos.x > gridWidth){
          cars.remove(cars.get(i));
          continue outer;
        }
      }
      
      
    }
  }
  
  return true;
}

//spawning new car every n ticks & cars cant spawn on the same y
void spawnCar(int roadId){
 boolean ok = false;
 int y = roadId == 0 ? (int)random(12) : (int)random(12, 24);
 Car nc = new Car(3, y);
 outer:
 do{
   for(Car c : cars){
     if(nc.gridPos.y == c.gridPos.y && nc.dir.x != c.dir.x){
       y = roadId == 0 ? (int)random(12) : (int)random(12, 24);
       nc = new Car(3, y);
       continue outer;
     }
   }
   
   for(int py : protectedY){
     if(nc.gridPos.y == py){
       y = roadId == 0 ? (int)random(12) : (int)random(12, 24);
       nc = new Car(3, y);
       continue outer;
     }
   }
   ok = true;
 }while(!ok);
 cars.add(nc);
}



void setup(){
  size(800, 600);
  frog = new Frog();
  cars = new ArrayList<Car>(); 
  map = loadStrings("map.txt");
}

void draw(){
 background(80); 
 noFill();
 
 int dirX = keyPressed && key == 'a' ? -1 : keyPressed && key == 'd' ? 1 : 0;
 int dirY = keyPressed && key == 'w' ? -1 : keyPressed && key == 's' ? 1 : 0;
 
 currentTick+=tickrate;
 if(currentTick % ticklen == 0){
   frog.update(new PVector(dirX, dirY));
   if(frog.gridPos.y < 0){
     frog = new Frog();
     score += 1;
   }
   if(!updateCars()) {
     cars.clear();
     frog = new Frog();
     score = 0;
     if(score % 5 == 0) carsToSpawn <<= 1;
   }
   if(currentTick % 500 == 0){
     //spawn new car on each road
     for(int i = 0; i < carsToSpawn; i++) spawnCar(i % 2);
   }
 }
 
 
 drawMap();
 frog.show();
 textSize(16);
 text("Score: " + score, 10, 20);
 for(Car c : cars) c.show();
}

Grid grid;
Population pop;

void setup() {
  size(500, 500);
  noStroke();
  frameRate(100);
  grid = new Grid();
  pop = new Population(25, grid); //25 generations
}

void draw() {
  background(225);
  grid.show();
  pop.evolve();
  
  /*if (frameCount % 200 == 0){
    saveFrame();
  }*/
}

public class Generation{
  private Car[] gen;
  private int num;
  private int curCar; //used for starting cars one at a time
  private int count; //number of cars in generation that have stopped
  
  public Generation(){ //initial generation
    num = 10; //first gen can be any size
    gen = new Car[num];
    
    for (int i = 0; i < num; i++){
      gen[i] = new Car(this);
    }
  
    curCar = 0;
    count = 0;
  }//end constructor initial generationn
  
  public Generation(Generation previous){
    num = 10; //depends on generation setup below
    gen = new Car[num];
    count = 0;
   
    previous.sort();
    
    for (int i = 0; i < 4; i++){
      gen[i] = new CarReincarnated(this, previous.get(i));
    }
        
    gen[4] = new CarBaby(this, gen[0], gen[1]);
    gen[5] = new CarBaby(this, gen[0], gen[2]);
    gen[6] = new CarBaby(this, gen[0], gen[3]);
    gen[7] = new CarBaby(this, gen[1], gen[2]);
    gen[8] = new CarBaby(this, gen[1], gen[3]);
    gen[9] = new CarBaby(this, gen[2], gen[3]);
    
    
  } //end constructor for later generations
  
  public void runOneAtTime(){ //run cars 1 at a time
      
      for (int i = 0; i < curCar && i < num; i++){
        gen[i].show();
      }
      
      if (frameCount % 20 == 0){
        curCar++;
      }
      
  }//end runAtTime()
  
  public void runAll(){
    for (int i = 0; i < num; i++){
      gen[i].show();
    }
  }
 
  public boolean finishedRun(){
    return count == num;
  }
  
  private void sort(){ //selection sort generation by fitness
    int i, j, max;
    
    for (i = 0; i < num-1; i++){
      max = i;
      for (j = i+1; j < num; j++){ 
        if (gen[j].framesAlive() > gen[max].framesAlive()){
          max = j;  
        }
      }//for j
      swap(i, max);
    }//for i
    
  }//end sort()
  
  private void swap(int a, int b){
    Car temp;
    temp = gen[a];
    gen[a] = gen[b];
    gen[b] = temp;
  }
  
  private Car get(int n){
    return gen[n];
  }
  
  public void carFinished(){
    count++;
  }
  
}//Generation class

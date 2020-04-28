public class Population{
  private Generation currentGen;
  private int currentGenNum;
  private int numGensToEvolve;
  private Grid grid;
  
  public Population(int numToEvolve, Grid g){
    currentGen = new Generation();
    currentGenNum = 1;
    numGensToEvolve = numToEvolve;
    grid = g;
  }
  
  private void nextGen(){
    currentGen = new Generation(currentGen); 
    currentGenNum++;
  }
  
  private void showText(){
    fill(255);
    textSize(18);
    text("Gen " + currentGenNum, 425, 25);
  }//end showText()
  
  public void evolve(){
    if (currentGenNum <= numGensToEvolve){
      
      if (currentGenNum > 6){
        currentGen.runOneAtTime();
      }
      else{
        currentGen.runAll();
      }
      
      if (currentGen.finishedRun() && currentGenNum < numGensToEvolve){
        nextGen();
        
        if (currentGenNum == 6){
          grid.change();
        }
      }
    }
    
    showText();
  }//end evolve()
  
  
  
  
  
  
  
  
  
  
  
  
  
}

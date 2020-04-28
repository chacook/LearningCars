public class Grid{
  private int[][] grid;
  
  public Grid(){
    grid = new int[][]{
      {1,1,1,0,0,1,1,1,0,0},
      {0,0,1,0,0,1,0,1,0,0},
      {0,0,1,0,1,1,0,1,0,0},
      {1,1,1,0,1,0,0,1,0,0},
      {1,0,0,0,1,0,1,1,0,0},
      {1,0,1,1,1,0,1,0,0,0},
      {1,0,1,0,0,0,1,0,0,0},
      {1,0,1,1,0,1,1,0,0,0},
      {1,0,0,1,0,1,0,0,0,0},
      {1,1,1,1,0,1,1,1,1,1}
    };
       
  }//end constructor
  
  public void show(){
    fill(0);
    noStroke();
    for(int j = 0; j < 10; j++){
      for (int i = 0; i < 10; i++){
        if(grid[i][j] == 0){ //non-track?
          rect(50*j,50*i,50,50);
        }//end non-track if
      }//end for i    
    }//end for j
    
    //make starting block green
    fill(0,175,0);
    rect(0,0,50,50);
    
    //make ending block red
    fill(175,0,0);
    rect(450,450,50,50);
  }//end show()
  
  public boolean checkOffTrack(float x, float y){ //check if a given point is off the track
   int col = (int)x / 50;
   int row = (int)y / 50;
   
   if (x < 0 || x >= width || y < 0 || y >= height){ //off screen?
     return true; 
   }
   else if(grid[row][col] == 0){ //black square?
     return true;  
   }
   else{ //on track
     return false;
   }
  }//end checkOffTrack();
  
  public boolean checkEndTrack(float x, float y){
    int col = (int)x / 50;
    int row = (int)y / 50;
    
    if (col == 9 && row == 9){
      return true;  
    }
    else{
      return false;  
    }
  }//end checkEndTrack()
  
  public void change(){
    grid = new int[][]{
      {1,1,1,1,1,1,0,0,0,0},
      {0,0,0,0,0,1,0,0,0,0},
      {1,1,1,0,1,1,0,0,0,0},
      {1,0,1,0,1,0,0,0,0,0},
      {1,0,1,0,1,0,1,1,1,1},
      {1,0,1,1,1,0,1,0,0,1},
      {1,0,0,0,0,0,1,0,1,1},
      {1,1,1,1,1,1,1,0,1,0},
      {0,0,0,0,0,0,0,0,1,0},
      {0,0,0,0,0,0,0,0,1,1}
    };
  }
  
}//end Grid class

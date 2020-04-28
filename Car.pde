public class Car{
  private float pivotX;
  private float pivotY;
  private float direction;
  private int carWidth;
  private int carHeight;
  private float angle;
  private color paint;
  private color lights;
  private float offset;
  private boolean alive;
  private float framesAlive;
  private boolean completedTrack;
  private Network network;
  private Generation gen;
  
  public Car(Generation g){
    pivotX = 25;
    pivotY = 25;
    direction = 1.5;
    carWidth = 10;
    carHeight = 20;
    paint = color(100,100,200);
    lights = color(255,255,0);
    angle = radians(90);  
    offset = carWidth/2;
    alive = true;
    framesAlive = -1;
    completedTrack = false;
    
    //random network
    network = new Network();
    
    gen = g;
  }//end constructor
  
  public void show(){
    pushMatrix();
    translate(pivotX, pivotY);
    rotate(angle);
    printCar();
    printHeadlights();
    popMatrix();
    
    drive();
    
    
    if (completedTrack()){
      direction = 0; 
    }
  } //end show()
  
  public void drive(){
    if (!collision()){
      pivotX += sin(angle) * direction;
      pivotY += -1 * cos(angle) * direction; //-1 is there since increasing y moves down in processing
     
      steer();
    }//not collided
  } //end drive()
  
  private void steer(){
    //get input
    float output = network.output(leftDist(), rightDist());
    
    //make decision
    if (output > 0){ //turn left
        turn(-PI/72); 
      }
    if(output < 0){ //turn right
      turn(PI/72);
    }

  }//end steer()
  
  private void printCar(){
    noStroke();
    fill(paint);
    rect(-1*offset, 0, carWidth, carHeight); 
  } //end printCar()
  
  private void printHeadlights(){
    noStroke();
    fill(lights);
    rect(0-offset,0,3,2);
    rect(carWidth-3-offset, 0, 3, 2);
  } //end printHeadlights()
  
  private void showCorners(){
    int radius = 3;
    fill(255,0,0);
    
    ellipse(frontLeftX(), frontLeftY(), radius, radius);
    ellipse(frontRightX(), frontRightY(), radius, radius);
    ellipse(backLeftX(), backLeftY(), radius, radius);
    ellipse(backRightX(), backRightY(), radius, radius);
    
    //show pivot point
    fill(0,255,0);
    ellipse(pivotX, pivotY, radius, radius);
  } //end showCorners()
  
  /*
  private float midDist(){
    float endX, endY, hyp;
    hyp = 0;
    endX = pivotX;
    endY = pivotY;
    
    while (!(grid.checkOffTrack(endX, endY))){
      //increase hyp
      hyp+= 0.01;
            
      //update endX, endY
      endX = pivotX + (hyp * sin(angle));
      endY = pivotY - (hyp * cos(angle));
    }
    //stroke(255,0,0);
    //line(pivotX, pivotY, endX, endY);
    return hyp;
  } //end midDist()
  */
  
  private float leftDist(){
    float endX, endY, hyp, secondaryAngle;
    hyp = 0;
    endX = frontLeftX();
    endY = frontLeftY();
    secondaryAngle = PI / 4;
    
    while (!(grid.checkOffTrack(endX, endY))){
      //increase hyp
      hyp += 0.01;
            
      //update endX, endY
      endX += (hyp * sin(angle - secondaryAngle));
      endY -= (hyp * cos(angle - secondaryAngle));
    }
    stroke(255,0,0);
    line(frontLeftX(), frontLeftY(), endX, endY);   
    return hyp;
  } //end leftDist()

  private float rightDist(){
    float endX, endY, hyp, secondaryAngle;
    hyp = 0;
    endX = frontRightX();
    endY = frontRightY();
    secondaryAngle = PI / 4;
    
    while (!(grid.checkOffTrack(endX, endY))){
      //increase hyp
      hyp+= 0.01;
            
      //update endX, endY
      endX += (hyp * sin(angle + secondaryAngle));
      endY -= (hyp * cos(angle + secondaryAngle));
    }
    stroke(255,0,0);
    line(frontRightX(), frontRightY(), endX, endY);   
    return hyp;
  } //end rightDist()
  
  public void reverse(){
    if (!collision()){
      pivotX += sin(angle) * direction *-1;
      pivotY += -1 * cos(angle) * direction *-1; //first -1 is there since increasing y moves down in processing, second is to reverse direction
    }
  }
  
  public void turn(float angleDiff){
    if (!collision()){
      angle += angleDiff;
      angle = angle % (2*PI);
    }
  }
  
  private float frontLeftX(){
    return pivotX - (offset * cos(angle));
  }
  
  private float frontLeftY(){
    return pivotY - (offset * sin(angle));
  }
  
  private float frontRightX(){
    if (angle > PI/2 || angle < 1.5*PI){
      return frontLeftX() + (carWidth * cos(angle));
    }
    else{
      return frontLeftX() - (carWidth * cos(angle));  
    }
  }
  
  private float frontRightY(){
    return frontLeftY() + (carWidth * sin(angle));  
  }
  
  private float backLeftX(){
    return frontLeftX() - (carHeight * cos((PI/2) - angle));
  }
  
  private float backLeftY(){
    return frontLeftY() + (carHeight * sin((PI/2) - angle));
  }
  
  private float backRightX(){
    if (angle > PI/2 || angle < 1.5*PI){
    return backLeftX() + (carWidth * cos(angle));
    }
    else{
      return backLeftX() - (carWidth * cos(angle));  
    }
  }
  
  private float backRightY(){
    return backLeftY() + (carWidth * sin(angle));  
  }
  
  
  public void changeColour(int r, int g, int b){
    paint = color(r,g,b);
  }
  
  private boolean collision(){
      if (alive && (grid.checkOffTrack(frontLeftX(), frontLeftY()) || grid.checkOffTrack(frontRightX(), frontRightY()) 
      || grid.checkOffTrack(backLeftX(), backLeftY()) || grid.checkOffTrack(backRightX(), backRightY()))){
          framesAlive = frameCount;
          //println(framesAlive);
          changeColour(225,100,100);
          alive = false;
          gen.carFinished();   
      }
    

    return !alive;
  }// end collision()
  
  private boolean completedTrack(){
    if (alive && (grid.checkEndTrack(frontLeftX(), frontLeftY()) || grid.checkEndTrack(frontRightX(), frontRightY()) 
    || grid.checkEndTrack(backLeftX(), backLeftY()) || grid.checkEndTrack(backRightX(), backRightY()))){
        framesAlive = frameCount;
        completedTrack = true;
        //println(framesAlive);
        changeColour(100,225,100);
        alive = false;
        gen.carFinished();
        
        return true;
    }
    return false;
  }// end completedTrack()
  
  public float framesAlive(){ //initially -1, updated upon crash/completion
    return framesAlive;  
  }
  
  public boolean successful(){
    if (completedTrack){
      return true;  
    }
    else{
      return false;  
    }
  }
  
  public void setNetwork(Network n){
    network = n;
  }
  
  public Network getNetwork(){
    return network;
  }
  
}//end Car class

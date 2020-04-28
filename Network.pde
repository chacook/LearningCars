public class Network{

  private float w1;
  private float w2;
  
  public Network(){
    w1 = random(-1,1);
    w2 = random(-1,1);
  }
  
  public Network(Network a, Network b){
    this.w1 = random(a.w1, b.w1);
    this.w2 = random(a.w2, b.w2);
  }
  
  public float output(float l, float r){
    float output = 0;
    output += (l * w1) + (r * w2);
    return output;
  }
 
}//class Network

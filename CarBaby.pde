public class CarBaby extends Car{
  
  public CarBaby(Generation g, Car a, Car b){
    super(g);
    setNetwork(new Network(a.getNetwork(), b.getNetwork()));
  }
}

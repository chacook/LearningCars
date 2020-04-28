public class CarReincarnated extends Car{
  
  public CarReincarnated(Generation g, Car oldSelf){
    super(g);
    setNetwork(oldSelf.getNetwork());
  }
}

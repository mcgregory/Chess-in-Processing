public class Pawn{
    
    boolean white;
    int column;
    int row;
    
  
    public Pawn(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
         
     
     
  
  
  
  void drawPawn(int check, int i, int j){
       
        PImage b;
        if(white){
            b = loadImage("white_pawn.jpg");
            image(b, i*check, j*check);
        }else{
            b = loadImage("black_pawn.jpg");
            image(b, i*check, j*check);
           
         }
         
        //fill(150); 
    
  }
  
  
}

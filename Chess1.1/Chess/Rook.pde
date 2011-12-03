public class Rook{
    
    boolean white;
    int column;
    int row;
    
  
    public Rook(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
         
     
     
  
  
  
  void drawRook(int check, int i, int j){
       
        PImage b;
        if(white){
            b = loadImage("white_rook.jpg");
            image(b, i*check, j*check);
        }else{
            b = loadImage("black_rook.jpg");
            image(b, i*check, j*check);
           
         }
         
        //fill(150); 
    
  }
  
  
}

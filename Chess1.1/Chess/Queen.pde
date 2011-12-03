public class Queen{
    
    boolean white;
    int column;
    int row;
    
  
    public Queen(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
         
     
     
  
  
  
  void drawQueen(int check, int i, int j){
       
        PImage b;
        if(white){
            b = loadImage("white_queen.jpg");
            image(b, i*check, j*check);
        }else{
            b = loadImage("black_queen.jpg");
            image(b, i*check, j*check);
           
         }
         
        //fill(150); 
    
  }
  
  
}

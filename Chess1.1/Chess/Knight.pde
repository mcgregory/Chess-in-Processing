public class Knight{
    
    boolean white;
    int column;
    int row;
    
  
    public Knight(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
         
     
     
  
  
  
  void drawKnight(int check, int i, int j){
       
        PImage b;
        if(white){
            b = loadImage("white_knight.jpg");
            image(b, i*check, j*check);
        }else{
            b = loadImage("black_knight.jpg");
            image(b, i*check, j*check);
           
         }
         
        //fill(150); 
    
  }
  
  
}

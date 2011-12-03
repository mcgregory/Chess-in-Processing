public class Bishop{
    
    boolean white;
    int column;
    int row;
    
  
    public Bishop(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
         
     
     
  
  
  
  void drawBishop(int check, int i, int j){
       
        PImage b;
        if(white){
            b = loadImage("white_bishop.jpeg");
            image(b, i*check, j*check);
        }else{
            b = loadImage("bishop.jpg");
            image(b, i*check, j*check);
           
         }
         
        //fill(150); 
    
  }
  
  
}

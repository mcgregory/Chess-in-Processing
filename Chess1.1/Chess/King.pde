public class King{
    
    boolean white;
    int column;
    int row;
    
  
    public King(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
      
    }
  
     /*    
     public boolean KingRules(int c, int r){
         
        
        
     }*/
      void drawKing(int check, int c, int r){
           
            PImage b;
            if(white){
                b = loadImage("white_king.jpg");
                image(b, c*check, r*check);
            }else{
                b = loadImage("black_king.jpg");
                image(b, c*check, r*check);
               
             }
             
            //fill(150); 
        
  }
  
  
}

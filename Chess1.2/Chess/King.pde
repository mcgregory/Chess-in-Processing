public class King{
    
    boolean white;
    int column, x1,y1;
    int row;
    
  
    public King(boolean pWhite, int pColumn, int pRow){
        white = pWhite;
        column = pColumn;
        row = pRow;
        x1 = pColumn;
        y1 = pRow;
      
    }
  
    public int getInitialx(){
      return x1;
    }
    public int getInitialy(){
      return y1;
    }
    
    void drawKing(int check, int c, int r){
           
            PImage b = new PImage(check/3,check/2);
            if(white){
                b = loadImage("white_king.png");
            b.resize(check-check/4,check-check/5);
                image(b, c*check, r*check);
            }else{
                b = loadImage("black_king.png");
            b.resize(check-check/4,check-check/5);
                image(b, c*check, r*check);
               
             }
             
            //fill(150); 
        
    }
  
  
}
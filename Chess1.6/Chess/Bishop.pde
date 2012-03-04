public class Bishop{
    
    boolean white;
    int column, x1,y1;
    int row;
    
  
    public Bishop(boolean pWhite, int pColumn, int pRow){
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
         
    void drawBishop(int check, int i, int j){
         
          PImage b = new PImage(check/3,check/2);
          if(white){
              b = loadImage("white_bishop.png");
              b.resize(check-check/4,check-check/5);
              image(b, i*check + check/15, j*check + check/15);
          }else{
              b = loadImage("black_bishop.png");
              b.resize(check-check/4,check-check/5);
              image(b, i*check + check/15, j*check + check/15);
             
           }
      
    }
    void drawDummyBishop(boolean wh, int check, int i, int j){
         
          PImage b = new PImage(check/3,check/2);
          if(wh){
              b = loadImage("white_bishop.png");
              b.resize(check-check/4,check-check/5);
              image(b, i*check + check/15, j*check + check/15);
          }else{
              b = loadImage("black_bishop.png");
              b.resize(check-check/4,check-check/5);
              image(b, i*check + check/15, j*check + check/15);
             
           }
      
    }
    
  
}

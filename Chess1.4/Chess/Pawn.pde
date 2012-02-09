public class Pawn{
    
    boolean white;
    int column, row, x1,y1;
    //x1, y1 for initial setting
  
    public Pawn(boolean pWhite, int pColumn, int pRow){
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
       
  
    void drawPawn(int check, int i, int j){
       
        PImage b = new PImage(check/3,check/2);
        if(white){
            b = loadImage("white_pawn.png");
            b.resize(check-check/4,check-check/5);
            image(b, i*check + check/15, j*check + check/15);
        }else{
            b = loadImage("black_pawn.png");
            b.resize(check-check/4,check-check/5);
            image(b, i*check + check/15, j*check + check/15);
           
         }
    
     }
     void drawDummyPawn(boolean wh, int check, int i, int j){
       
        PImage b = new PImage(check/3,check/2);
        if(wh){
            b = loadImage("white_pawn.png");
            b.resize(check-check/5,check-check/6);
            image(b, i*check + check/15, j*check + check/15);
        }else{
            b = loadImage("black_pawn.png");
            b.resize(check-check/5,check-check/6);
            image(b, i*check + check/12, j*check + check/12);
           
         }
    
     }
  
  
}

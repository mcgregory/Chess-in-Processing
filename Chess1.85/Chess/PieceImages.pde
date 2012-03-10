//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory

//the purpose of this class, is to only load image once
public class PieceImages    {
      
      PImage whitepawn;
      PImage blackpawn;
      PImage whitebishop;
      PImage blackbishop;
      PImage whiteknight;
      PImage blackknight;
      PImage whiterook;
      PImage blackrook;
      PImage whitequeen;
      PImage blackqueen;
      PImage whiteking;
      PImage blackking;
      
      int sqsize;
      
      public PieceImages(){
          sqsize = 20;
      }
      
      public PieceImages(int squaresize){
            sqsize = squaresize;
      } 
      void setup(){
        
            whitepawn = loadImage("white_pawn.png");
            blackpawn  = loadImage("black_pawn.png");
            whitebishop = loadImage("white_bishop.png");
            blackbishop = loadImage("black_bishop.png");
            whiteknight = loadImage("white_knight.png");
            blackknight = loadImage("black_knight.png");
            whiterook = loadImage("white_rook.png");
            blackrook = loadImage("black_rook.png");
            whitequeen = loadImage("white_queen.png");
            blackqueen = loadImage("black_queen.png");
            whiteking = loadImage("white_king.png");
            blackking = loadImage("black_king.png");
        
            resizeImages(sqsize);
      }
      public void setSquareSize(int squareSize){
          sqsize = squareSize;
      }
      public void resizeImages(int sqrsz){
       
            whitepawn.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackpawn.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            whitebishop.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackbishop.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            whiteknight.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackknight.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            whiterook.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackrook.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            whitequeen.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackqueen.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            whiteking.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
            blackking.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5); 
        
      }
      
}

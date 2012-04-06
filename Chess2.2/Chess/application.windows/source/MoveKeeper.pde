//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory

//this class will store every move that has occured in a move
  //piece number
  //piece killed in move
  //destination and previous x,y
  //points at that time
public class MoveKeeper{
  
  
       int piecenumber;
       int pieceNumKilled;
       int x,y,px,py;
       boolean promotionOccurred;
       //PVector destination, previous;
       
       //default constructor
       public MoveKeeper(){
               piecenumber= -1;
               pieceNumKilled = -1;
               //destination = new PVector(-1,-1);
               //previous = new PVector(-1,-1);
               promotionOccurred = false;
               x=-1;
               y=-1;
               px= -1;
               py = -1;
               
       }
       //constructor
       public MoveKeeper(int pnum, int row, int col, int prevx, int prevy, int pieceNumKill, boolean promotionOcc){
               piecenumber= pnum;
               pieceNumKilled = pieceNumKill;
               //destination = new PVector(row,col);
               //previous = new PVector(prevx,prevy);
               
               x=row;
               y=col;
               px= prevx;
               py = prevy;
               promotionOccurred = promotionOcc;
       }
       public void setMove(int prevx, int prevy,int col, int row, int pnum){
         
               x=row;
               y=col;
               px= prevx;
               py = prevy;
               piecenumber= pnum;
       }
       public boolean getPromotionOccurred(){
             return promotionOccurred;
       }
       
}

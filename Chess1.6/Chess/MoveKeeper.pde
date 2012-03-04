//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory

//this class will store every move that has occured 
public class MoveKeeper{
  
  
       int piecenumber;
       //int x,y,px,py;
       PVector destination, previous;
       
       public MoveKeeper(int pnum, int row, int col, int prevx, int prevy){
               piecenumber= pnum;
               destination = new PVector(row,col);
               previous = new PVector(prevx,prevy);
               /*
               x=row;
               y=col;
               px= prevx;
               py = prevy;
               */
       }
       
}

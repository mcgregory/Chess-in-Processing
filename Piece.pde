public class Piece{
 
       int pColumn;
       int pRow;
       int pType;
       boolean pLive = true;
       boolean pWhite;
       
       public Piece( int column, int row, int type, boolean isWhite ) {
         pColumn = column;
         pRow = row;
         pType = type;
         pWhite = isWhite;
       }
       
       int getRow(){
         return(pRow);
       }
      
       int getColumn(){
         return(pColumn);
       }
      
       int getType(){
         return(pType);
       }
       boolean getLive(){
          return(pLive); 
       }
      
       boolean getPWhite(){
         return(pWhite);
       }
       
       void setColumn(int column){
         if( pLive ){
           pColumn = column;
         }
       }
      
       void setRow(int row){
         if( pLive ){
           pRow = row;
         }
       }
      
       void setType(int type){
         if( pLive ){
           pType = type;
         }
       }
       void setLive(boolean live){
          pLive = live;
       }
       
       void end(){
         pLive = false;
         pRow = -1;
         pColumn = -1;
         pType = 0;
       }
           
  }

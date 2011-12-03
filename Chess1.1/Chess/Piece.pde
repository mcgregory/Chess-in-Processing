public class Piece{
 
      int pColumn;
      int pRow;
      boolean pLive = true;
      boolean pWhite;
      int pType; 
      Pawn pawn;
      Bishop bishop;
      King king;
      Knight knight;
      Queen queen;
      Rook rook;
      
      public Piece( int column, int row, int type, boolean isWhite ){
           pColumn = column;
           pRow = row;
           pWhite = isWhite;
           pType = type;
           if(type ==1){
              pawn = new Pawn(isWhite,column, row);
             
           } 
           if(type ==2){
              rook = new Rook(isWhite,column, row);
             
           }
           if(type ==3){
              knight = new Knight(isWhite,column, row);
             
           }
           if(type ==4){
              bishop = new Bishop(isWhite,column, row);
             
           }
           if(type ==5){
              queen = new Queen(isWhite,column, row);
             
           }
           if(type ==6){
              king = new King(isWhite,column, row);
             
           }
           
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
       
       void drawPiece(int check, int i, int j){
           if(pType ==1){
              pawn.drawPawn(check,i,j);
             
           } 
          if(pType ==2){
              rook.drawRook(check,i,j);
             
           }
           if(pType ==3){
              knight.drawKnight(check,i,j);
             
           }
           if(pType ==4){
              bishop.drawBishop(check,i,j);
             
           }
           if(pType ==5){
              queen.drawQueen(check,i,j);
             
           }
           if(pType ==6){
              king.drawKing(check,i,j);
             
           }
         
         
       }
           
  }

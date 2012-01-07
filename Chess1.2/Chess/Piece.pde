public class Piece{
      //variables for a piece
      int pColumn;
      int pRow;
      boolean pLive = true;
      boolean pWhite;
      boolean firstMove =true;
      int pType; 
      int[][] squaresAttacked = new int[21][2];
      //initialize pieces
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
           
           //create determined by type
           if(type ==1){
              pawn = new Pawn(isWhite,column, row);
             
           } 
           else if(type ==2){
              rook = new Rook(isWhite,column, row);
             
           }
           else if(type ==3){
              knight = new Knight(isWhite,column, row);
             
           }
           else if(type ==4){
              bishop = new Bishop(isWhite,column, row);
             
           }
           else if(type ==5){
              queen = new Queen(isWhite,column, row);
             
           }
           else if(type ==6){
              king = new King(isWhite,column, row);
             
           }
           
       }//end of constructor
       
       //------------------------------------------------------------------------
       //gets, sets
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
           if(pType ==1){
              pawn.column = column;
             
           } 
           else if(pType ==2){
              rook.column = column;
             
           }
           else if(pType ==3){
              knight.column = column;
             
           }
           else if(pType ==4){
              bishop.column = column;
             
           }
           else if(pType ==5){
              queen.column = column;
             
           }
           else if(pType ==6){
              king.column = column;
             
           }
           pColumn = column;
           firstMove=false;
       }
      
       void setRow(int row){
           if(pType ==1){
              pawn.row = row;
             
           } 
           else if(pType ==2){
              rook.row = row;
             
           }
           else if(pType ==3){
              knight.row = row;
             
           }
           else if(pType ==4){
              bishop.row = row;
             
           }
           else if(pType ==5){
              queen.row = row;
             
           }
           else if(pType ==6){
              king.row = row;
             
           }
         
           pRow = row;
           firstMove=false;
       }
      
       void setType(int type){
         if( pLive ){
           pType = type;
         }
       }
       void setLive(boolean live){
          pLive = live;
       }
       
       //kill or end piece:
       void end(){
         pLive = false;
         pRow = -1;
         pColumn = -1;
         pType = 0;
       }
       //get initial x for piece
       public int getInitx(){
           if(pType ==1){
              return pawn.getInitialx();
             
           } 
           else if(pType ==2){
              return rook.getInitialx();
             
           }
           else if(pType ==3){
              return knight.getInitialx();
             
           }
           else if(pType ==4){
              return bishop.getInitialx();
             
           }
           else if(pType ==5){
              return queen.getInitialx();
             
           }
           else if(pType ==6){
              return king.getInitialx();
             
           }else{
               return -1;
           }
       }
       //get initial x for piece
       public int getInity(){
           if(pType ==1){
              return pawn.getInitialy();
             
           } 
           else if(pType ==2){
              return rook.getInitialy();
             
           }
           else if(pType ==3){
              return knight.getInitialy();
             
           }
           else if(pType ==4){
             return bishop.getInitialy();
             
           }
           else if(pType ==5){
              return queen.getInitialy();
             
           }
           else if(pType ==6){
              return king.getInitialy();
             
           }else{
               return -1;
           }
       }
       
       
       //find which piece type it is and draw it:
       void drawPiece(int check, int i, int j){
           if(pType ==1){
              pawn.drawPawn(check,i,j);
             
           } 
           else if(pType ==2){
              rook.drawRook(check,i,j);
             
           }
           else if(pType ==3){
              knight.drawKnight(check,i,j);
             
           }
           else if(pType ==4){
              bishop.drawBishop(check,i,j);
             
           }
           else if(pType ==5){
              queen.drawQueen(check,i,j);
             
           }
           else if(pType ==6){
              king.drawKing(check,i,j);
             
           }
         
         
       }
           
  }

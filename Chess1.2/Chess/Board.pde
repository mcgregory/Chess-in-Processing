

public class Board {
  
       int check;
       Piece[] pieces = new Piece[32]; //never going to be more than 32
       boolean ok = false;    
       int oldx;
       int oldy;
       int whosTurn, count;
       boolean promotion;
       boolean clickedYet= false;
   
       
           
       public Board(int squareSize) { //const.
               
                 if(squareSize > 0) {
                   check = squareSize;
                   
                 } 
                 else {
                   check = 20;
                   
                  }
               
                   /* setting the pawns to correct pos.*/
                   pieces[0] = new Piece( 0, 6, 1, true );//white
                   pieces[1] = new Piece( 1, 6, 1, true );
                   pieces[2] = new Piece( 2, 6, 1, true );
                   pieces[3] = new Piece( 3, 6, 1, true );
                   pieces[4] = new Piece( 4, 6, 1, true );
                   pieces[5] = new Piece( 5, 6, 1, true );
                   pieces[6] = new Piece( 6, 6, 1, true );
                   pieces[7] = new Piece( 7, 6, 1, true );
                   pieces[8] = new Piece( 0, 1, 1, false );//black
                   pieces[9] = new Piece( 1, 1, 1, false );
                   pieces[10] = new Piece( 2, 1, 1, false );
                   pieces[11] = new Piece( 3, 1, 1, false );
                   pieces[12] = new Piece( 4, 1, 1, false );
                   pieces[13] = new Piece( 5, 1, 1, false );
                   pieces[14] = new Piece( 6, 1, 1, false );
                   pieces[15] = new Piece( 7, 1, 1, false );
                   /*end of setting pawns*/
                   //setting majors
                   pieces[16] = new Piece( 0, 7, 2, true );//rook
                   pieces[17] = new Piece( 1, 7, 3, true );//knight
                   pieces[18] = new Piece( 2, 7, 4, true );//bishop
                   pieces[19] = new Piece( 3, 7, 6, true );//queen
                   pieces[20] = new Piece( 4, 7, 5, true );//king
                   pieces[21] = new Piece( 5, 7, 4, true );//bishop
                   pieces[22] = new Piece( 6, 7, 3, true );//knight
                   pieces[23] = new Piece( 7, 7, 2, true );//rook
                   pieces[24] = new Piece( 0, 0, 2, false );
                   pieces[25] = new Piece( 1, 0, 3, false );
                   pieces[26] = new Piece( 2, 0, 4, false );
                   pieces[27] = new Piece( 3, 0, 6, false );//queen
                   pieces[28] = new Piece( 4, 0, 5, false );//king
                   pieces[29] = new Piece( 5, 0, 4, false );
                   pieces[30] = new Piece( 6, 0, 3, false );
                   pieces[31] = new Piece( 7, 0, 2, false );    
         
               
         }
         //draw method being called in runner 
       void draw(){
               stroke(color(150));
               
               //first check for mouse pressed
               if (mousePressed == true) {
                mouseClicked();
                clickedYet = true; //this way mouseClicked doesnt get called twice in same loop
              }else{
                clickedYet = false;
              }
               
               
               for ( int i=0; i<8; i++ ) {
                   for ( int j=0; j<8; j++ ) {
                         drawEmpty(i,j);
                         
                          rect( (i*check), (j*check), check, check);
                         // Draw a piece if there is one there.
                         if( !isEmptyAt(i, j) ){
                               drawPieces(i,j);
                               //fill(150);
                          } 
                     }
                 }
                 
              if (mousePressed == true && !clickedYet ) {
                mouseClicked();
              }
                 
       }
         
      public void drawEmpty(int column, int row){
                   
           if( ((column + row) % 2) == 1){
              fill(color(255));
           }
           else{
              fill(color(25,195,25)); 
           }
      }   
      public void drawPieces(int column,int row){
            if( getPieceNum(column,row) != -1){ 
                pieces[getPieceNum(column,row)].drawPiece(check,column,row);      
            }else{
                drawEmpty(column, row);
            }
       }

      public int getPieceNum(int column, int row){ 
            for( int i = 0; i< pieces.length  ; i++) {
               if ( ( pieces[i].getColumn() == column ) && ( pieces[i].getRow() == row ) ) {
                 return( i );
               }
             }
             return(-1);
         
         
      }
      public int getPieceType(int column, int row ) {
            if(getPieceNum(column, row) != -1){
                 return( pieces[getPieceNum(column, row)].getType() );
                 
            }
            else{     
                return(0);
            }
        
      }
        
      public boolean boolWhite(int column, int row ) {
            
             if(getPieceNum(column, row) != -1){
                 println("piece num not -1, now checking ");
                println("getPWhite = " + pieces[getPieceNum(column, row)].getPWhite());
                 return( pieces[getPieceNum(column, row)].getPWhite() );
             }
             
             else{     
                 return(false);
             }
              
       }
       public boolean isEmptyAt(int column, int row ){
         
               return( getPieceType(column, row) == 0 );
       }
        //----------------------------------------------------------------------------------------
        //Move valid methods:
       
       //pawn move valid 
       boolean pawnMoveValid(int x, int y, int pNX, int pNY, int firstClickPN){
            println("in pawnMoveValid");
            
             //if the pawn is white
           if(boolWhite(pNX,pNY)){ 
                  println("pawn is white");
                  //move one forward but never with a piece there
                  if(isEmptyAt(x,y) && x== pNX && y == pNY-1){
                    return true;
                  }
                  //the capturing of a piece to the right
                  else if(!isEmptyAt(x,y) && !boolWhite(x,y) && x== pNX+1 && y == pNY-1){
                      return true;
                  }
                  //the capturing of a piece to the left
                  else if(!isEmptyAt(x,y) && !boolWhite(x,y) &&  x== pNX-1 && y == pNY-1){
                      return true;
                  }
                  //only move 2 spaces when it's the first move:
                  else if(isEmptyAt(x,y) && x== pNX && y == pNY-2 && pNX == pieces[firstClickPN].getInitx() 
                          && pNY == pieces[firstClickPN].getInity()){
                    
                      return true;
                  }
                  else{
                    return false;
                    
                  }
                  
           }
           //if pawn is black
           else if(!boolWhite(pNX,pNY)){ 
                  println("pawn is black");
                  //move one forward but never with a piece there
                  if(isEmptyAt(x,y) && x== pNX && y == pNY+1){
                    return true;
                  }
                  //the capturing of a piece to the right
                  else if(!isEmptyAt(x,y) && boolWhite(x,y) && x== pNX-1 && y == pNY+1){
                      return true;
                  }
                  //the capturing of a piece to the left
                  else if(!isEmptyAt(x,y) && boolWhite(x,y) &&  x== pNX+1 && y == pNY+1){
                      return true;
                  }
                  //only move 2 spaces when it's the first move:
                  else if(isEmptyAt(x,y) && x== pNX && y == pNY+2 && pNX == pieces[firstClickPN].getInitx() 
                          && pNY == pieces[firstClickPN].getInity()){
                    
                      return true;
                  }
                  else{
                    return false;
                    
                  }
           } else {
              return false;
            }
            
            
       } 
        
        
        
       //checks destination x,y and whether certain piece can move there
       boolean moveIsValid(int x, int y, int pNX, int pNY, int type, int firstClickPN){
         println("check on moveIsValid");
             if(type ==1 ){
               println("type is a pawn");
               return pawnMoveValid(x, y, pNX, pNY, firstClickPN);
             } /*
             if(type ==2){
                //rook = new Rook(isWhite,column, row);
               
             }
             if(type ==3){
                //knight = new Knight(isWhite,column, row);
               
             }
             if(type ==4){
                //bishop = new Bishop(isWhite,column, row);
               
             }
             if(type ==5){
                //queen = new Queen(isWhite,column, row);
               
             }
             if(type ==6){
                //king = new King(isWhite,column, row);
               
             }*/
         else {return false;}
         
       }//end of moveIsValid---------------------------------------------
       
        
        
        
        
        
        
       //------------------------------------------------------------------------------------------ 
        int firstClickPN = -1; //piece number from first click
        
       void mouseClicked() {
          
                //destination x,y     
                int x = int(mouseX/check);
                int y = int(mouseY/check);
                  
              if(firstClickPN != -1){
                    
                        //piece location x,y
                        int pNY =  pieces[firstClickPN].getRow();;
                        int pNX = pieces[firstClickPN].getColumn();
                        int type = pieces[firstClickPN].getType();
                      
                        if(moveIsValid(x,y,pNX,pNY, type, firstClickPN)){
                          println("in mouse move valid is true");
                              if(!isEmptyAt(x,y )){   
                                   int pieceNum = getPieceNum(x , y );
                                   pieces[pieceNum].end();         
                              }
                           
                               pieces[firstClickPN].setRow(y);
                               pieces[firstClickPN].setColumn(x);
                               println("piece set: x= " +mouseX/check+ "; y= "+ mouseY/check);
                               firstClickPN = -1;
                        }else{
                             println("Invalid move!"); 
                             firstClickPN = -1;
                        }
                } else if(isEmptyAt(x,int(mouseY/check ))) {
                      println("No piece present: x= " +mouseX/check+ "; y= "+ mouseY/check);
                      firstClickPN = -1;
                  
                } else if(getPieceNum(int(mouseX/check ), y) != -1 && firstClickPN == -1 ){
                      int pieceNum = getPieceNum(x , y );
                      firstClickPN = pieceNum;
                       println("~present: x= " +mouseX/check+ "; y= "+ mouseY/check);
                } else{
                      firstClickPN = -1;
                      println("x= " +mouseX/check+ "; y= "+ mouseY/check);
                }
             
          
         }

        
       
}
          


//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


public class Piece  /*extends Bishop, King, Knight, Pawn, Queen, Rook*/  {
      //variables for a piece
      int pColumn;
      int pRow;
      boolean pWhite, flickOn;
      boolean firstMove = true; 
      boolean pLive =true; 
      int pType, pCheck; 
      int[][] attackedSquares = new int[21][2];
      
      
      //initialize pieces
      Pawn pawn;
      Bishop bishop;
      King king;
      Knight knight;
      Queen queen;
      Rook rook;
      
      //constructor for dummy object:
      public Piece(){
           pawn = new Pawn(pWhite,0, 0);
           rook = new Rook(pWhite,0, 0);
           knight = new Knight(pWhite,0, 0);
           bishop = new Bishop(pWhite,0, 0);
           queen = new Queen(pWhite,0, 0);
           king = new King(pWhite,0, 0);
           flickOn =false;
      }
      //constructor
      public Piece( int column, int row, int type, int check, boolean isWhite ){
           pColumn = column;
           pRow = row;
           pWhite = isWhite;
           pType = type;
           pCheck = check;
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
           
           flickOn =false;
           
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
       boolean getFlickOn(){
          return(flickOn); 
       }
       void setColumn(int column){
           if( pLive ){
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
           }
       }
      
       void setRow(int row){
           if( pLive ){
                 if(pType ==1){
                    pawn.row = row;
                    
                    if (pWhite && row == 0){
                        //set up a clean text box:
                        //fill(150);
                        //stroke(225);
                        //rect( (8*pCheck)+2, (2*pCheck-pCheck/2)+2, pCheck, pCheck);
                        fill(255);
                        text("Promote Pawn:", (8*pCheck)+3, (2*pCheck-pCheck/2)+5, pCheck, pCheck );
                        flickOn = true;
                    }
                    else if(!pWhite && row == 7){
                        //set up a clean text box:
                        //fill(150);
                        //stroke(225);
                        //rect( (8*pCheck)+2, (2*pCheck)+2, pCheck, pCheck);
                        fill(255);
                        text("Promote Pawn:", 8*pCheck+5, 3 , pCheck, pCheck );
                        flickOn = true;
                    }
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
           }
         
       }
       void promote(int type){
             //prob not needed for pawn but whatever 
             if(type ==1){
                pawn = new Pawn(pWhite,pColumn, pRow);
             } 
             else if(type ==2){
                rook = new Rook(pWhite,pColumn, pRow);
               
             }
             else if(type ==3){
                knight = new Knight(pWhite,pColumn, pRow);
               
             }
             else if(type ==4){
                 bishop = new Bishop(pWhite,pColumn, pRow);
               
             }
             else if(type ==5){
                queen = new Queen(pWhite,pColumn, pRow);
               
             }
             pType = type;
       }
      
       void setType(int type){
         if( pType != type ){
             pType = type;
         }
       }
       void setLive(boolean live){
          pLive = live;
       }
       void setFlickOn(boolean on){
           flickOn = on; 
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
                
             if(pLive){
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
       
       //method for promotion, allows for drawing any piece
       //find which piece type it is and draw it:
       void drawAnyPiece(boolean white, int type, int check, int i, int j){
                
               if(type ==1){
                  pawn.drawDummyPawn(white,check,i,j);
                 
               } 
               else if(type ==2){
                  rook.drawDummyRook(white,check,i,j);
                 
               }
               else if(type ==3){
                  knight.drawDummyKnight(white,check,i,j);
                 
               }
               else if(type ==4){
                  bishop.drawDummyBishop(white,check,i,j);
                 
               }
               else if(type ==5){
                  queen.drawDummyQueen(white,check,i,j);
                 
               }
               else if(type ==6){
                  king.drawDummyKing(white,check,i,j);
                 
               }
               
         
       }
           
  }

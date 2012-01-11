//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory

public class Board {
  
       int check;
       Piece[] pieces = new Piece[32]; //never going to be more than 32
       int oldx, oldy, count, wkingx,wkingy,bkingx,bkingy;
       boolean promotion;
       boolean whiteTurn = true;
       boolean clickedYet, selected, showCheck = false;
       int selx, sely = -1;
       
           
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
                   pieces[19] = new Piece( 3, 7, 5, true );//queen
                   pieces[20] = new Piece( 4, 7, 6, true );//king
                   pieces[21] = new Piece( 5, 7, 4, true );//bishop
                   pieces[22] = new Piece( 6, 7, 3, true );//knight
                   pieces[23] = new Piece( 7, 7, 2, true );//rook
                   pieces[24] = new Piece( 0, 0, 2, false );
                   pieces[25] = new Piece( 1, 0, 3, false );
                   pieces[26] = new Piece( 2, 0, 4, false );
                   pieces[27] = new Piece( 3, 0, 5, false );//queen
                   pieces[28] = new Piece( 4, 0, 6, false );//king
                   pieces[29] = new Piece( 5, 0, 4, false );
                   pieces[30] = new Piece( 6, 0, 3, false );
                   pieces[31] = new Piece( 7, 0, 2, false );    
         
       }
//---------------------------------------------------------------------------------------------------       
       void setup(){
              //load font 
              PFont font;
              font = loadFont("AgencyFB-Reg-22.vlw"); 
              textFont(font);
              
              for (int i=0; i<32;i++){
                  setAttackedSquares(i);
              }
              wkingx = pieces[20].getColumn();
              wkingy = pieces[20].getRow();
              bkingx = pieces[28].getColumn();
              bkingy = pieces[28].getRow();
       }
//---------------------------------------------------------------------------------------------------
       //draw method being called in Chess 
       void draw(){
               
              wkingx = pieces[20].getColumn();
              wkingy = pieces[20].getRow();
              bkingx = pieces[28].getColumn();
              bkingy = pieces[28].getRow();     
         
              stroke(20);
               
              for ( int i=0; i<8; i++ ) {
                   for ( int j=0; j<8; j++ ) {
                         drawEmpty(i,j);
                         
                         rect( (i*check), (j*check), check, check);
                         // Draw a piece if there is one there.
                         if( !isEmptyAt(i, j) ){
                               drawPieces(i,j);
                         } 
                     }
               } 
               //if selection then highlight
               if (selx !=-1 && firstClickPN != -1){
                   highlight(selx,sely);
                   hltPossMoves(firstClickPN);
               }
               if(showCheck){
                   display("CHECK!"); 
               }
               
       }
//---------------------------------------------------------------------------------------------------       
//methods       
      
      public void highlight(int x, int y){
          
          stroke(250,25,25);
          fill(25,25,250,100);
          rect( (x*check), (y*check), check, check);
      }
      public void display(String s){
          fill(250);
          text(s, 8*check+10, 10, check, check);
        
      }
      public void drawEmpty(int column, int row){
                   
           if( ((column + row) % 2) == 1){
              stroke(0);
              fill(color(25,195,25)); 
           }
           else{
              stroke(0);
              fill(color(255)); 
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
                 return( pieces[getPieceNum(column, row)].getPWhite() );
             }
             
             else{     
                 return(false);
             }
              
       }
       public boolean isEmptyAt(int column, int row ){
         
               return( getPieceType(column, row) == 0 );
       }
       
//--------------------------------------------------------------------------------------------------
 //Piece restrictions/rules:
 //rook rules:
  
      private boolean rookRules(int x, int y, int pNX, int pNY, int firstClickPN){
        
                
                 boolean canmove = false;
          
                 //do this if x changes and y does not:
                 if(x != pNX && y == pNY){
                    
                              //if the destination x is smaller than original x then 
                              //make sure there are no pieces between desination
                              if(pNX > x){
                                
                                      int i = 1;   
                                      boolean boo=true;
                                    
                                      while(boo && i< pNX-x){
                                         
                                           //check each square to be empty to the left
                                            if(isEmptyAt(pNX -i,pNY)){
                                              boo = true;
                                            }else{
                                              canmove = false;
                                              boo = false;
                                            }
                                            i++;
                                      }
                                      //move is valid
                                      if (boo){
                                          canmove = boo;
                                      }
                                      return canmove;
                              }
                              //if the destination x is larger than original x then 
                              //make sure there are no pieces between desination
                              else if(pNX < x){
                                      int i = 1;   
                                      boolean boo=true;
                                    
                                      while(boo && i< x-pNX){
                                         
                                           //check each square to be empty to the right
                                            if(isEmptyAt(pNX + i,pNY)){
                                              boo = true;
                                            }else{
                                              canmove = false;
                                              boo = false;
                                            }
                                            i++;
                                      }
                                      //move is valid
                                      if (boo){
                                          canmove = boo;
                                      }
                                      return canmove;
                              }
                              else{
                                return false;
                              }
                          
                          
                  }
                  //do this if x does not change and y does:
                  else if(x == pNX && y != pNY){
                    
                              //if the destination y is smaller than original y then 
                              //make sure there are no pieces between desination
                              if(pNY > y){
                                 println("5");
                                      int i = 1;   
                                      boolean boo=true;
                                    
                                      while(boo && i< pNY-y){
                                         
                                           //check each square to be empty to the left
                                            if(isEmptyAt(pNX,pNY-i)){
                                              boo = true;
                                            }else{
                                              canmove = false;
                                              boo = false;
                                            }
                                            i++;
                                      }
                                      //move is valid
                                      if (boo){
                                          canmove = boo;
                                      }
                                      return canmove;
                              }
                              //if the destination y is larger than original y then 
                              //make sure there are no pieces between desination
                              else if(pNY < y){
                                      int i = 1;   
                                      boolean boo=true;
                                    
                                      while(boo && i< y-pNY){
                                         
                                           //check each square to be empty to the right
                                            if(isEmptyAt(pNX,pNY + i)){
                                              boo = true;
                                            }else{
                                              canmove = false;
                                              boo = false;
                                            }
                                            i++;
                                      }
                                      //move is valid
                                      if (boo){
                                          canmove = boo;
                                      }
                                      return canmove;
                              }
                              else{
                                return false;
                              }
                    
                  }
                  else{
                     return false; 
                  }
        
      
       
        } 
//-----------------------------------------------------------------------------------------------------      
  //bishop rules:
        private boolean bishopRules(int x, int y, int pNX, int pNY, int firstClickPN){
                  
                  boolean canmove = false;
                  int dis =0;
                  boolean boo=true;
          
                  //a move up and left 
                  if ((pNX - x) == (pNY - y)){
                            dis = pNX - x; //distance
                
                            int i = 1;       
                              
                            while(boo && i< dis){
                                 //check each square to be empty to the left 1 n up 1
                                  if(!isEmptyAt(pNX - i,pNY - i)){
                                    boo = false;
                                  }else{
                                    i++;
                                  }
                            }
                            //move is valid?
                            canmove = boo;
                  }
                  //a move up and right 
                  if ((x - pNX) == (pNY - y) && (x - pNX) > 0 && (pNY - y) > 0 ){
                           dis = x - pNX; //distance
                            int i = 1; 
                            
                            while(boo && i< dis){
                               
                                 //check each square to be empty to the right 1 and up 1
                                  if(!isEmptyAt(pNX + i,pNY - i)){
                                    boo = false;
                                  }else{
                                    i++;
                                  }
                            }
                            //move is valid?
                            canmove = boo;
                  }
                  //a move down and left 
                  if ((pNX - x) == (y - pNY) && (pNX - x) > 0 && (y - pNY) > 0 ){
		            dis = pNX - x;
                            int i = 1;       
                              
                            while(boo && i< dis){
                               
                                 //check each square to be empty to the left 1 and down 1
                                  if(!isEmptyAt(pNX - i,pNY + i)){
                                    boo = false;
                                  }else{
                                    i++;
                                  }
                            }
                            //move is valid?
                            canmove = boo;
                  }
                  //a move down and right
                  if ((x - pNX) == (y - pNY)){
		        dis = x - pNX;
			int i = 1; 
                              
                            while(boo && i< dis){
                               
                                 //check each square to be empty to the left 1 and down 1
                                  if(!isEmptyAt(pNX + i,pNY + i)){
                                    boo = false;
                                  }else{
                                    i++;
                                  }
                            }
                            //move is valid?
                            canmove = boo;
                  }
                  
                  return canmove;    
      
      
        }
      
//-----------------------------------------------------------------------------------------------------
//Move valid methods:
       
       
       
//TYPE #1       
       //pawn move valid 
       public boolean pawnMoveValid(int x, int y, int firstClickPN){
                
               int pNX = pieces[firstClickPN].getColumn();
               int pNY = pieces[firstClickPN].getRow();
                
               //if the pawn is white
               if(boolWhite(pNX,pNY)){ 
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
//----------------------------------------------------------------------------------------------
//TYPE #2       
       //rook move valid 
       public boolean rookMoveValid(int x, int y, int firstClickPN){
              
                int pNX = pieces[firstClickPN].getColumn();
                int pNY = pieces[firstClickPN].getRow();
                int pieceNum = -1;
              
                //checks destination isnt same color piece  
                  if(!isEmptyAt(x,y )){   
                         pieceNum = getPieceNum(x , y ); 
                  }
                  if (pieceNum!= -1){
                          //move is not valid if x,y destination has a same color piece
                          if (pieces[pieceNum].getPWhite() == pieces[firstClickPN].getPWhite()){
                                 return false; 
                          }
                  }
                 //end of check for same color capture
                
                return rookRules(x, y, pNX, pNY, firstClickPN);
                  
            
       }//this ends rook restrictions
//---------------------------------------------------------------------------------------------
//TYPE #3:

        //Knight restrictions:
        public boolean knightMoveValid(int x, int y, int firstClickPN){
                
                  int pNX = pieces[firstClickPN].getColumn();
                  int pNY = pieces[firstClickPN].getRow();
                  int pieceNum = -1;
                  boolean canmove = false;
                  
                  //checks destination isnt same color piece  
                  if(!isEmptyAt(x,y )){   
                         pieceNum = getPieceNum(x , y ); 
                  }
                  if (pieceNum!= -1){
                          //move is not valid if x,y destination has a same color piece
                          if (pieces[pieceNum].getPWhite() == pieces[firstClickPN].getPWhite()){
                                 return false; 
                          }
                  }
                 //end of check for same color capture
                    
                  if (((pNY == y - 1) || (pNY == y + 1)) && ((pNX == x + 2) || (pNX == x - 2))){
  			canmove = true;
                  }
  		  if ((pNY == y - 2 || pNY == y + 2) && ((pNX == x + 1) || (pNX == x - 1))){
  			canmove = true; 
                  }
                  return canmove;
        }  // end of Knight restrictions
//------------------------------------------------------------------------------------------------------
//TYPE #4:

        //Bishop restrictions:
        public boolean bishopMoveValid(int x, int y, int firstClickPN){
                    
                    int pNX = pieces[firstClickPN].getColumn();
                    int pNY = pieces[firstClickPN].getRow();
                    int pieceNum = -1;
                    
                    //checks destination isnt same color piece  
                        if(!isEmptyAt(x,y )){   
                               pieceNum = getPieceNum(x , y ); 
                        }
                        if (pieceNum!= -1){
                                //move is not valid if x,y destination has a same color piece
                                if (pieces[pieceNum].getPWhite() == pieces[firstClickPN].getPWhite()){
                                       return false; 
                                }
                        }
                    //end of check for same color capture    
                        
                    return bishopRules(x, y, pNX, pNY, firstClickPN);
    
    
        }//end of Bishop restrictions, type#4
//--------------------------------------------------------------------------------------------------
      
//TYPE #5 
        //Queen restrictions:
        //uses bishop and rook rules
        public boolean queenMoveValid(int x, int y, int firstClickPN){
                  
                    int pNX = pieces[firstClickPN].getColumn();
                    int pNY = pieces[firstClickPN].getRow();
                    int pieceNum = -1;
                      
                    //checks destination isnt same color piece  
                    if(!isEmptyAt(x,y )){   
                           pieceNum = getPieceNum(x , y ); 
                    }
                    if (pieceNum!= -1){
                            //move is not valid if x,y destination has a same color piece
                            if (pieces[pieceNum].getPWhite() == pieces[firstClickPN].getPWhite()){
                                   return false; 
                            }
                    }
                    //end of check for same color capture
                    
                    if(bishopRules(x, y, pNX, pNY, firstClickPN) || rookRules(x, y, pNX, pNY, firstClickPN)){
                         return true;
                    }else{
                         return false;
                    }
                      
                    
        }
//--------------------------------------------------------------------------------------------------
      
//TYPE #6 
      public boolean kingMoveValid(int x, int y, int firstClickPN){
      
                  int pNX = pieces[firstClickPN].getColumn();
                  int pNY = pieces[firstClickPN].getRow();
                  int pieceNum = -1;
                  boolean canmove = false;
      
                 //checks destination isnt same color piece  
                  if(!isEmptyAt(x,y )){   
                         pieceNum = getPieceNum(x , y ); 
                  }
                  if (pieceNum!= -1){
                          //move is not valid if x,y destination has a same color piece
                          if (pieces[pieceNum].getPWhite() == pieces[firstClickPN].getPWhite()){
                                 return false; 
                          }
                  }
                 //end of check for same color capture
      
                  if (pNY == y - 1 && pNX == x - 1){
			canmove = true;
                  }
	          else if (pNY == y && pNX == x - 1){
			canmove = true;
                  }
		  else if (pNY == y + 1 && pNX == x - 1){
			canmove = true;
                  }
		  else if (pNY == y - 1 && pNX == x){
			canmove = true;
                  }
		  else if (pNY == y + 1 && pNX == x){
			canmove = true;
		  }
                  else if (pNY == y - 1 && pNX == x + 1){
			canmove = true;
                  }
		  else if (pNY == y  && pNX == x + 1){
		        canmove = true;
                  }
		  else if (pNY == y + 1 && pNX == x + 1){
			canmove = true;
                  }
                  else{
                        canmove = false;
                  }
                  
                  //only castle when it's the first move:
                  if(pNX == pieces[firstClickPN].getInitx() && pNY == pieces[firstClickPN].getInity() && pieces[firstClickPN].firstMove){
                             
                             //if white
                             if(pieces[firstClickPN].pWhite){
                                      //if queenside castle
                                      if(pNX == x+2){
                                          //empty?
                                          if(isEmptyAt(x,y) && isEmptyAt(x+1,y) && isEmptyAt(x-1,y) ) {  
                                                 pieces[16].setRow(7);
                                                 pieces[16].setColumn(3);    
                                                 canmove = true;
                                          }
                                      
                                      }
                                      //if kingside castle
                                      else if(pNX == x -2) {
                                            //empty
                                            if(isEmptyAt(x,y) && isEmptyAt(x-1,y)  ) {
                                                  pieces[23].setRow(7);
                                                  pieces[23].setColumn(5);     
                                                  canmove = true;
                                            }
                                      }
                              }
                              //if black
                              else {
                                    //if queenside
                                    if(pNX == x+2){
                                          //empty?
                                        if(isEmptyAt(x,y) && isEmptyAt(x+1,y) && isEmptyAt(x-1,y) ) {  
                                               pieces[24].setRow(0);
                                               pieces[24].setColumn(3);    
                                               canmove = true;
                                        }
                                    
                                    } 
                                    //if kingside
                                    if(pNX == x -2) {  
                                        //empty
                                          if(isEmptyAt(x,y) && isEmptyAt(x-1,y)) { 
                                                pieces[31].setRow(0);
                                                pieces[31].setColumn(5);     
                                                canmove = true;
                                          }
                                
                                    }
                             }
                                
                    }   
                    if(canmove){
                          if(pieces[firstClickPN].pWhite){
                              wkingx = pieces[20].getColumn();
                              wkingy = pieces[20].getRow();
                          }else{
                              bkingx = pieces[28].getColumn();
                              bkingy = pieces[28].getRow();
                          }  
                    }
                    return canmove;
          
      }
//--------------------------------------------------------------------------------------------------
       
       //checks destination x,y and whether certain piece can move there
       boolean moveIsValid(int x, int y,  int firstClickPN){
                 
                     int pNX = pieces[firstClickPN].getColumn();
                     int pNY = pieces[firstClickPN].getRow();
                     int type = pieces[firstClickPN].getType();
                     
                     if(type ==1 ){
                           return pawnMoveValid(x, y, firstClickPN);
                     } 
                     else if(type ==2){
                           return rookMoveValid(x, y, firstClickPN);
                       
                     }
                     else if(type ==3){
                           return knightMoveValid(x, y, firstClickPN);
                       
                     }
                     else if(type ==4){
                           return bishopMoveValid(x, y, firstClickPN);
                     }
                     else if(type ==5){
                           return queenMoveValid(x, y, firstClickPN);
                       
                     }
                     else if(type ==6){
                           return kingMoveValid(x, y, firstClickPN);
                       
                     }
                     else {return false;}
         
       }//end of moveIsValid---------------------------------------------
       
        
  //end of restrictions/rules
//------------------------------------------------------------------------------------------ 
       int firstClickPN = -1; //piece number from first click
        
       void mouseClicked() {
          
                //destination x,y     
                int x = int(mouseX/check);
                int y = int(mouseY/check);
                  
                  
                if(firstClickPN != -1){
                      //check if valid, if it's right color's turn
                      if(whiteTurn == pieces[firstClickPN].pWhite){
                            
                                 //piece location x,y
                                 int pNY = pieces[firstClickPN].getRow();;
                                 int pNX = pieces[firstClickPN].getColumn();
                                
                                
                                 if(moveIsValid(x,y, firstClickPN)){
                                         
                                         if(!isEmptyAt(x,y )){   
                                              int pieceNum = getPieceNum(x , y );
                                              pieces[pieceNum].end();         
                                         }
                                     
                                         pieces[firstClickPN].setRow(y);
                                         pieces[firstClickPN].setColumn(x);
                                         println("piece set: x= " +mouseX/check+ "; y= "+ mouseY/check);
                                         resetAttack(firstClickPN);
                                         setAttackedSquares(firstClickPN);
                                         
                                         if(inCheck(firstClickPN) && firstClickPN != -1){
                                              showCheck = true;
                                              draw();
                                         }else{
                                              showCheck = false; 
                                         }
                                         
                                         whiteTurn = !whiteTurn;  
                                         firstClickPN = -1;
                                        
                                  }else{
                                       display("Invalid Move!"); 
                                       firstClickPN = -1;
                                  }
                                  
                                  selx = -1;
                                  sely = -1;  
                      }
                      //not this color's turn
                      else{
                           String bw;
                        
                           if (whiteTurn){
                               bw = "BLACK'S";
                           }
                           else{
                               bw = "WHITE'S";
                           }
                           String mess = "NOT " + bw + " TURN";
                           display(mess); 
                           firstClickPN = -1;
                      }
          
                }
                //no piece present at x,y
                else if(isEmptyAt(x,int(mouseY/check ))) {
                      display("Empty Square");
                      firstClickPN = -1;
                      selx = -1;
                      sely = -1;
                } 
                //piece is present at x,y; set as highlighted
                else if(getPieceNum(int(mouseX/check ), y) != -1 && firstClickPN == -1 ){
                      int pieceNum = getPieceNum(x , y );
                      firstClickPN = pieceNum;
                      resetAttack(firstClickPN);
                      setAttackedSquares(firstClickPN);
                      selx = x;
                      sely = y;
                      
                      println("~present: x= " +mouseX/check+ "; y= "+ mouseY/check);
                } else{
                      firstClickPN = -1;
                      selx = -1;
                      sely = -1;
                      println("x= " +mouseX/check+ "; y= "+ mouseY/check);
                }
                      
       }
       
//-----------------------------------------------------------------------------------------------------
//checking kings:


       public void setAttackedSquares(int pieceNum){
        
         
              int m = 0;
              //store all possible moves of this piece
              for ( int i=0; i<8; i++ ) {
                   for ( int j=0; j<8; j++ ) {
                         
                         if(moveIsValid(i,j, pieceNum) && m<21){
                              
                               pieces[pieceNum].attackedSquares[m][0] = i;
                               pieces[pieceNum].attackedSquares[m][1] = j;
                               m++;
                              
                          }
                     }
               } 
       }
       //highlight posible moves
       public void hltPossMoves(int pieceNum){
             
             int x,y, count =0;  
             
             for ( int i=0; i<21; i++ ) {
               
                       x = pieces[pieceNum].attackedSquares[i][0];
                       y = pieces[pieceNum].attackedSquares[i][1];
                       
                       if(x !=0 || y != 0){
                         highlight(x,y);
                       }else if(i==0 && x == 0 && y == 0){
                         highlight(x,y);
                       }
                       else if(i>1 && x == 0 && y == 0){
                         i=21;
                       }
                       else if(count == 2){
                         i=21;
                       }
                       else{
                           count++;
                       }  
             }
         
       }
       
       //reset attackedSquares
       public void resetAttack(int pieceNum){
         
             for ( int i=0; i<21; i++ ) {
                           
                    pieces[pieceNum].attackedSquares[i][0] =0;
                    pieces[pieceNum].attackedSquares[i][1] =0;      
             } 
         
       }
       //in check by piece?
       public boolean inCheck(int pieceNum){
             
             boolean ischeck = false;
             int i=0; 
             //if the piece given is white, check if it attacks the black king
             if (pieces[pieceNum].pWhite){
                   while (!ischeck && i<21){
                         if (bkingx ==  pieces[pieceNum].attackedSquares[i][0] && bkingy == pieces[pieceNum].attackedSquares[i][1]){
                              ischeck = true; 
                         }
                         else {
                              i++; 
                         }
                   }
             }
             //else means piece given is black, check if it attacks white king
             else{
                   while (!ischeck && i<21){
                         if (wkingx ==  pieces[pieceNum].attackedSquares[i][0] && wkingy == pieces[pieceNum].attackedSquares[i][1]){
                              ischeck = true;
                         }
                         else {
                              i++; 
                         }
                   }
             }
             println("isCheck: " + ischeck);
             return ischeck;
         
       }
       //check all pieces of white/black for check
       public boolean currentKingInCheck(boolean white){
               
               boolean ischeck = false;
               int i=0; 
               
               //white
               if(white){
                   //loop for pieceNum
                   for(int k =8; k<32;k++){
                         
                         //if black piece only 8-15,24-31
                         if(k<16 || k>23){
                               //loop for attackedSquares[_]
                               while (!ischeck && i<21){
                                     if (wkingx ==  pieces[k].attackedSquares[i][0] && wkingy == pieces[k].attackedSquares[i][1]){
                                          ischeck = true;
                                          return true;
                                     }
                                     else {
                                          i++; 
                                     }
                               }
                         }
                   }
               }
               else{
                    //loop for pieceNum
                    for(int k =0; k<24;k++){
                         //if white piece only 0-7,16-23
                         if(k<8 || k>15){
                               //loop for attackedSquares[_]
                               while (!ischeck && i<21){
                                     if ( bkingx ==  pieces[k].attackedSquares[i][0] && bkingy == pieces[k].attackedSquares[i][1]){
                                          ischeck = true;
                                          return true;
                                     }
                                     else {
                                          i++; 
                                     }
                               }
                         }
                    }
               }
               
               return ischeck;
         
         //if(currentKingInCheck(pieces[firstClickPN].pWhite)){
                                              
           
         
         
       }
}
          


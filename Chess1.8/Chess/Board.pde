//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory

public class Board {
  
       Piece[] pieces = new Piece[33]; //never going to be more than 32, 32 is dummy object for drawing anypiece
       MoveKeeper[] moveKeeper = new MoveKeeper[85]; //no need to keep track of that many moves
       
       int moveCounter =0;
       int squSize, killCounter, whitePoints, blackPoints;
       int oldx, oldy, count, wkingx,wkingy,bkingx,bkingy;
       int selx, sely = -1;
       int firstClickPN = -1; //piece number from first click
       boolean promotion = false;
       boolean booUndo = false;
       boolean whiteTurn = true;
       boolean clickedYet, selected, showCheck, attackSetYet, resetOn = false;
       boolean doPop = false;
       boolean enPassant = false;
       
       String wpts = "WPts: ";
       String bpts = "BPts: ";
           
       //const.    
       public Board(int squareSize) { 
               
               
                 if(squareSize > 0) {
                   squSize = squareSize;
                 } 
                 else {
                   squSize = 20;
                 }
                   /* setting the pawns to correct pos.*/
                   pieces[0] = new Piece( 0, 6, 1, squareSize, true );//white
                   pieces[1] = new Piece( 1, 6, 1,squareSize, true );
                   pieces[2] = new Piece( 2, 6, 1,squareSize, true );
                   pieces[3] = new Piece( 3, 6, 1,squareSize, true );
                   pieces[4] = new Piece( 4, 6, 1,squareSize, true );
                   pieces[5] = new Piece( 5, 6, 1,squareSize, true );
                   pieces[6] = new Piece( 6, 6, 1,squareSize, true );
                   pieces[7] = new Piece( 7, 6, 1,squareSize, true );
                   pieces[8] = new Piece( 0, 1, 1,squareSize, false );//black
                   pieces[9] = new Piece( 1, 1, 1,squareSize, false );
                   pieces[10] = new Piece( 2, 1, 1,squareSize, false );
                   pieces[11] = new Piece( 3, 1, 1,squareSize, false );
                   pieces[12] = new Piece( 4, 1, 1,squareSize, false );
                   pieces[13] = new Piece( 5, 1, 1,squareSize, false );
                   pieces[14] = new Piece( 6, 1, 1,squareSize, false );
                   pieces[15] = new Piece( 7, 1, 1,squareSize, false );
                   /*end of setting pawns*/
                   //setting majors
                   pieces[16] = new Piece( 0, 7, 2,squareSize, true );//rook
                   pieces[17] = new Piece( 1, 7, 3, squareSize,true );//knight
                   pieces[18] = new Piece( 2, 7, 4, squareSize,true );//bishop
                   pieces[19] = new Piece( 3, 7, 5, squareSize,true );//queen
                   pieces[20] = new Piece( 4, 7, 6, squareSize,true );//king
                   pieces[21] = new Piece( 5, 7, 4, squareSize,true );//bishop
                   pieces[22] = new Piece( 6, 7, 3, squareSize,true );//knight
                   pieces[23] = new Piece( 7, 7, 2, squareSize,true );//rook
                   pieces[24] = new Piece( 0, 0, 2, squareSize,false );
                   pieces[25] = new Piece( 1, 0, 3, squareSize,false );
                   pieces[26] = new Piece( 2, 0, 4, squareSize,false );
                   pieces[27] = new Piece( 3, 0, 5, squareSize,false );//queen
                   pieces[28] = new Piece( 4, 0, 6, squareSize,false );//king
                   pieces[29] = new Piece( 5, 0, 4, squareSize,false );
                   pieces[30] = new Piece( 6, 0, 3, squareSize,false );
                   pieces[31] = new Piece( 7, 0, 2, squareSize,false );   
                   pieces[32] = new Piece(squareSize);//dummy
       }
//---------------------------------------------------------------------------------------------------       
       void setup(){
              //load font 
              PFont font;
              font = loadFont("AgencyFB-Reg-21.vlw"); 
              textFont(font);
              textSize(squSize/4.5);
              killCounter =0;
              whitePoints =0;
              blackPoints =0;
              println("setup Board");
              
              wkingx = pieces[20].getColumn();
              wkingy = pieces[20].getRow();
              bkingx = pieces[28].getColumn();
              bkingy = pieces[28].getRow();
       }
//---------------------------------------------------------------------------------------------------
       //draw method being called in Chess 
       void draw(){ 
              //this is a translate and rotate to change view for black
              
              if (!whiteTurn && !doPop){
                    pushMatrix();
                      // move the origin to the pivot point
                    translate(8*squSize, 8*squSize); 
      
                    // then pivot the grid
                    rotate(radians(180));
                    doPop = true;
              }
               //draw empty board
               drawBoardEmpty();
               
               //if selection then highlight
               if (selx !=-1 && firstClickPN != -1){
                   highlight(selx,sely);
                   hltPossMoves(firstClickPN);
               }
               
               if(doPop){ 
                  
                  popMatrix(); 
                  //draw pieces with doPop still true
                  drawBoardPieces();
                  doPop = !doPop;
               }else{
                 
                 //draw pieces on board 
                 drawBoardPieces(); 
               }
               //set up a restart/reset box:
                fill(50);
                stroke(255);
                rect( (8*squSize)+2, (7*squSize)+3, squSize, squSize/3 );
                fill(255);
                if(resetOn){
                    text(" Click Again", (8*squSize)+5, (7*squSize)+5, squSize, squSize/3 );
                }
                else{
                    text(" New Game", (8*squSize)+5, (7*squSize)+5, squSize, squSize/3 );
                }
                //end of box setup
                //set up a undo move box:
                fill(50);
                stroke(255);
                rect( (8*squSize)+2, (7*squSize)+squSize/2, squSize, squSize/3 );
                fill(255);
                if(booUndo){
                    text("Click Again", (8*squSize)+5, (7*squSize+5)+squSize/2, squSize, squSize/3 );
                }
                else{
                    text("Undo Move", (8*squSize)+5, (7*squSize+5)+squSize/2, squSize, squSize/3 );
                }
                //end of box setup
                
                //text for points
                wpts = "  WPts: " + whitePoints;
                bpts = "  BPts: " + blackPoints;
                fill(50);
                rect( (8*squSize)+2, (6*squSize), squSize, squSize*2/3);
                fill(255);
                text(wpts, (8*squSize)+2, (6*squSize), squSize, squSize/2);
                text(bpts, (8*squSize)+2, (6*squSize)+squSize/3, squSize, squSize/2); 
               
               if(showCheck){
                   display("CHECK!"); 
               }
               
               if(whiteTurn){
                 displayWhosTurn("White's Move");
               }else{
                 displayWhosTurn("Black's Move");
               }
               
               
               //printing which pieces are alive:
               
               for (int r =0; r<32;r++){
                 println("Piece Number: "+r+ "; Alive?: " + pieces[r].pLive + "; at: " +pieces[r].getColumn() + "," + pieces[r].getRow());
               }
               
               //this is a translate and rotate to change view for black
              
       }       
//--------------------------------------------------------------------------------------------------- 
void drawBoardEmpty(){
  
            stroke(20);
            for ( int i=0; i<8; i++ ) {
                 for ( int j=0; j<8; j++ ) {
                       drawEmpty(i,j);
                       rect( (i*squSize), (j*squSize), squSize, squSize);
                   }
             }
  
}
void drawBoardPieces(){
  
            stroke(20);
            for ( int i=0; i<8; i++ ) {
                 for ( int j=0; j<8; j++ ) {
                       
                       // Draw a piece if there is one there.
                       if( !isEmptyAt(i, j) ){
                            drawPieces(i,j);
                       } 
                   }
             }
}

//--------------------------------------------------------------------------------------------------- 
//Reset method:
      public void reset(){
        
               
               promotion = false;
               whiteTurn = true;
               selx = -1;
               sely = -1;    
               firstClickPN = -1;
               killCounter =0;
               whitePoints =0;
               blackPoints =0;
               moveCounter =0;
               
               for ( int i =0; i<32; i++){
                  pieces[i].resetPiece(); 
               }
        
      }
//---------------------------------------------------------------------------------------------------              
      public void storeMove(int pnumber, int x, int y, int px,int py, int pnklld){
        
               moveKeeper[moveCounter] = new MoveKeeper(pnumber,x,y,px,py,pnklld);
        
      }
//---------------------------------------------------------------------------------------------------    

//---------------------------------------------------------------------------------------------------              
      public void undoMove(){
              if(moveCounter != 0){
                   moveCounter--;
                   whiteTurn = !whiteTurn;
                   if(moveKeeper[moveCounter].piecenumber != -1){
                         //reset to previous position, x,y points, bring killed pieces back to life if occured 
                         //all these need to be done here!
                         
                         pieces[moveKeeper[moveCounter].piecenumber].setRow(moveKeeper[moveCounter].py);
                         pieces[moveKeeper[moveCounter].piecenumber].setColumn(moveKeeper[moveCounter].px);
                         //revive piece killed in that move
                         if(moveKeeper[moveCounter].pieceNumKilled !=-1){
                             //also need to take points back
                                   pieces[moveKeeper[moveCounter].pieceNumKilled].bringLife();
                                   int tp;
                                   tp = pieces[moveKeeper[moveCounter].pieceNumKilled].getType();
                                        
                                    if (whiteTurn && tp != -1){
                                           if(tp ==1){
                                               whitePoints = whitePoints - 1;
                                           } 
                                           else if(tp ==2){
                                               whitePoints = whitePoints - 5;
                                           }
                                           else if(tp ==3){
                                               whitePoints = whitePoints - 3;
                                           }
                                           else if(tp ==4){
                                               whitePoints = whitePoints - 3;
                                           }
                                           else if(tp ==5){
                                               whitePoints = whitePoints - 9;
                                           }
                                    }
                                    else if( tp != -1){
                                          if(tp ==1){
                                              blackPoints = blackPoints -1;
                                           } 
                                           else if(tp ==2){
                                              blackPoints = blackPoints -5;
                                           }
                                           else if(tp ==3){
                                              blackPoints = blackPoints -3;
                                           }
                                           else if(tp ==4){
                                              blackPoints = blackPoints -3;
                                           }
                                           else if(tp ==5){
                                              blackPoints = blackPoints -9;
                                           }
                                    }   
                         }
                         
                         setupAttackedSquaresForEachPiece();
                   }
                   else{
                       moveCounter++; 
                       whiteTurn = !whiteTurn;
                   }
              }
      }
//---------------------------------------------------------------------------------------------------  
       public void drawPromotionPieces(){
       
                //set up a box:
                fill(125);
                stroke(225);
                rect( (8*squSize)+3, (2*squSize), squSize -6, 4*squSize);
                
                //draw the pieces for the user to choose from:
                pieces[32].drawAnyPiece(pieces[firstClickPN].getPWhite(), 2,squSize, 8, 2);
                pieces[32].drawAnyPiece(pieces[firstClickPN].getPWhite(), 3,squSize, 8, 3);
                pieces[32].drawAnyPiece(pieces[firstClickPN].getPWhite(), 4,squSize, 8, 4);
                pieces[32].drawAnyPiece(pieces[firstClickPN].getPWhite(), 5,squSize, 8, 5);
         
       }
//---------------------------------------------------------------------------------------------------       
//methods       
      public void setupAttackedSquaresForEachPiece(){
              for (int i=0; i<32;i++){
                  resetAttack(i);
                  setAttackedSquares(i);
              } 
      }
      public void highlight(int x, int y){
          
          stroke(250,25,25);
          fill(125,5,225,150);
          rect( (x*squSize), (y*squSize), squSize, squSize );
      }
      int cnt = 0;
      public void display(String s){
          
          if (cnt ==2){
              cnt = 0;
          }
          fill(255);
          if(cnt != 0){
            text(s, 8*squSize+5, 3 + (cnt*squSize/2), squSize-squSize/15, ((cnt)*squSize/2) -3 );
          }
          else{
            text(s, 8*squSize+5, 3 + (cnt*squSize/2), squSize-squSize/15, squSize/3 -3 );
          }
          cnt++;
      }
      public void displayWhosTurn(String s){
          //first clear the area:
          fill(75);
          stroke(200);
          rect( (8*squSize)+2, squSize+5, squSize, squSize/2);  
        
          fill(255);
          text(s, 8*squSize+10, squSize+20, squSize, squSize);
      }
      public void drawEmpty(int column, int row){
           if( ((column + row) % 2) == 1){
              stroke(0);
              fill(color(25,125,50)); 
           }
           else{
              stroke(0);
              fill(240); 
           }
      }   
      public void drawPieces(int column,int row){
            if( getPieceNum(column,row) != -1  ){ 
                if(doPop){
                    //rotate(radians(180));
                    pieces[getPieceNum(column,row)].drawPiece(squSize,(7-column),(7-row)); 
                    //rotate(radians(180));   
                }else{
                    pieces[getPieceNum(column,row)].drawPiece(squSize,column,row);  
                }  
            }else{
                drawEmpty(column, row);
            }
       }
      public int getPieceNum(int column, int row){ 
           //search all pieces to see if any hold the x,y, if so then  return it's number
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
                return(-1);
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
               if( getPieceNum(column, row) != -1){
                  return( !pieces[ getPieceNum(column, row)].pLive);
               }else{ 
                  return(true);
               }
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
       //DONT FORGET TO ADD EN PASSANT!!!
//TYPE #1       
       //pawn move valid 
       public boolean pawnMoveValid(int x, int y, int firstClickPN, boolean realMove){
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
                       else if(moveCounter-1 > 0 ){
                             
                             if(pieces[moveKeeper[moveCounter-1].piecenumber].pType == 1 && pNY == 3){
                                  if (abs(moveKeeper[moveCounter-1].y - moveKeeper[moveCounter-1].py) == 2){
                                      if(moveKeeper[moveCounter-1].x - 1 == pNX && x== pNX+1 && y == pNY-1 ){
                                              println("*************up right**********" +abs(moveKeeper[moveCounter-1].y - moveKeeper[moveCounter-1].py));
                                              if (realMove){
                                                enPassant = true;
                                              }
                                              return true;
                                      }
                                      else if( moveKeeper[moveCounter-1].x + 1 == pNX && x== pNX-1 && y == pNY-1) {
                                        println("**********up left****" +abs(moveKeeper[moveCounter-1].y - moveKeeper[moveCounter-1].py));
                                               if (realMove){
                                                enPassant = true;
                                               }
                                               return true;
                                                
                                      }
                                  }
                             }
                              return false;
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
                      else if(moveCounter-1 > 0 ){
                             
                             if(pieces[moveKeeper[moveCounter-1].piecenumber].pType == 1  && pNY == 4){
                                  if (abs(moveKeeper[moveCounter-1].y - moveKeeper[moveCounter-1].py) == 2){
                                      if(moveKeeper[moveCounter-1].x - 1 == pNX && x== pNX+1 && y == pNY+1 ){
                                              println("*****************************************" +abs(moveKeeper[moveCounter-1].y - moveKeeper[moveCounter-1].py));
                                              if (realMove){
                                                enPassant = true;
                                              }
                                              return true;
                                      }
                                      else if( moveKeeper[moveCounter-1].x + 1 == pNX && x== pNX-1 && y == pNY+1) {
                                              if (realMove){
                                                enPassant = true;
                                              }
                                              return true;
                                                
                                      }
                                  }
                             }
                              return false;
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
                    int pieceNumb = -1;
                    //checks destination isnt same color piece  
                        if(!isEmptyAt(x,y )){   
                               pieceNumb = getPieceNum(x , y ); 
                        }
                        if (pieceNumb!= -1){
                                //move is not valid if x,y destination has a same color piece
                                if (pieces[pieceNumb].getPWhite() == pieces[firstClickPN].getPWhite()){
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
                  if( bishopRules(x, y, pNX, pNY, firstClickPN) || rookRules(x, y, pNX, pNY, firstClickPN) ){
                       return true;
                  }else{
                       return false;
                  }
      }
//--------------------------------------------------------------------------------------------------
      
//TYPE #6 
      public boolean kingMoveValid(int x, int y, int firstClickPN, boolean actualMove){
      
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
                  if(pNX == pieces[firstClickPN].getInitx() && pNY == pieces[firstClickPN].getInity() && pieces[firstClickPN].firstMove && actualMove){
                            
                             //if white
                             if(pieces[firstClickPN].pWhite){
                                      //if queenside castle
                                      if(pNX == x+2){
                                          //empty?
                                          if(isEmptyAt(x,y) && isEmptyAt(x+1,y) && isEmptyAt(x-1,y) && allowMove(x,y,20) && allowMove(x+1,y,20) && allowMove(x-1,y,20) ) {  
                                                 pieces[16].setRow(7);
                                                 pieces[16].setColumn(3);    
                                                 canmove = true;
                                          }
                                      
                                      }
                                      //if kingside castle
                                      else if(pNX == x -2) {
                                            //empty
                                            if(isEmptyAt(x,y) && isEmptyAt(x-1,y) && allowMove(x,y,20) && allowMove(x-1,y,20) ) {
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
                                        if(isEmptyAt(x,y) && isEmptyAt(x+1,y) && isEmptyAt(x-1,y) && allowMove(x,y,28) && allowMove(x-1,y,28) && allowMove(x+1,y,28) ) {  
                                               pieces[24].setRow(0);
                                               pieces[24].setColumn(3);    
                                               canmove = true;
                                        }
                                    } 
                                    //if kingside
                                    if(pNX == x -2) {  
                                        //empty
                                          if(isEmptyAt(x,y) && isEmptyAt(x-1,y) && allowMove(x,y,28) && allowMove(x-1,y,28) ) { 
                                                pieces[31].setRow(0);
                                                pieces[31].setColumn(5);     
                                                canmove = true;
                                          }
                                    }
                             }
                    }   
                    return canmove;
      }
//--------------------------------------------------------------------------------------------------
       
       //checks destination x,y and whether certain piece can move there
       boolean moveIsValid(int x, int y,  int firstClickPN, boolean actualMove){
                 
                     int pNX = pieces[firstClickPN].getColumn();
                     int pNY = pieces[firstClickPN].getRow();
                     int type = pieces[firstClickPN].getType();
                     if(type ==1 ){
                           return pawnMoveValid(x, y, firstClickPN, actualMove);
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
                           return kingMoveValid(x, y, firstClickPN, actualMove);
                       
                     }
                     else {return false;}
       }//end of moveIsValid---------------------------------------------
  //end of restrictions/rules
//--------------------------------------------------------------------------------------------------------
//checking kings:
       public void setAttackedSquares(int pieceNum){
              int m = 0;
              //store all possible moves of this piece
              for ( int i=0; i<8; i++ ) {
                   for ( int j=0; j<8; j++ ) {
                         if(moveIsValid(i,j, pieceNum, false) && m<21){
                               pieces[pieceNum].attackedSquares[m][0] = i;
                               pieces[pieceNum].attackedSquares[m][1] = j;
                               m++;
                          }
                     }
               } 
       }
//-----------------------------------------------------------------------------------------------------
       //highlight posible moves
       public void hltPossMoves(int pieceNum){
             
             int x,y, count =0;  
             
             for ( int i=0; i<21; i++ ) {
               
                       x = pieces[pieceNum].attackedSquares[i][0];
                       y = pieces[pieceNum].attackedSquares[i][1];
                       
                       if(x !=-1 && y != -1){
                         highlight(x,y);
                       }else if(i==0 && x == 0 && y == 0){
                         highlight(x,y);
                       }
                       else if(i>1 && x == -1 && y == -1){
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
                    pieces[pieceNum].attackedSquares[i][0] =-1;
                    pieces[pieceNum].attackedSquares[i][1] =-1;      
             } 
       }
//---------------------------------------------------------------------------------------------------------
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
//-----------------------------------------------------------------------------------------------------
       //check all pieces of white/black for check
       public boolean currentKingInCheck(boolean white){
               
               boolean ischeck = false;
               int i=0; 
               //white
               if(white){               
                   //loop for pieceNum
                   for(int k =8; k<32;k++){
                         //black piece only 8-15,24-31
                         if(k<16 || k>23){
                               //loop for attackedSquares[_]
                               while (!ischeck && i<21){
                                     if (pieces[20].getColumn() ==  pieces[k].attackedSquares[i][0] && pieces[20].getRow() == pieces[k].attackedSquares[i][1]){
                                          ischeck = true;
                                          println("white king in check");
                                          return true;
                                     }
                                     else {
                                          i++;
                                     }
                               }
                               i=0;
                         }
                   }
               }
               else{
                    //loop for pieceNum
                    for(int k =0; k<24;k++){
                         //white piece only 0-7,16-23
                         if(k<8 || k>15){
                               //loop for attackedSquares[_]
                               while (!ischeck && i<21){
                                 //if(k==19 && pieces[k].attackedSquares[i][0] != -1){println("This is currentKingInCheck, k, i "+k+","+i+ " attacked squares are: "+pieces[k].attackedSquares[i][0]+ ","+pieces[k].attackedSquares[i][1]);}
                                 
                                     if ( pieces[28].getColumn() ==  pieces[k].attackedSquares[i][0] && pieces[28].getRow() == pieces[k].attackedSquares[i][1]){
                                          ischeck = true;
                                          println("black king in check");
                                          return true;
                                     }
                                     else {
                                          i++; 
                                     }
                               }
                               i=0;
                         }
                    }
               }
               println(", is check: " + ischeck);
               return ischeck;
       }
//---------------------------------------------------------------------------------------------------------
  //method to check the kings moves after a check occurs and whether it can go there
  
      public boolean canKingMove(boolean white){
          
           if (white){printattackedsquaresfor(28);
               //white move resulted in a check of the black king, check if bking can move
               for ( int i=0; i<8; i++ ) {
                   if(pieces[28].attackedSquares[i][0] != -1){
                      if(moveIsValid(pieces[28].attackedSquares[i][0], pieces[28].attackedSquares[i][1], 28, false)){   
                        println("king move is valid through restrictions for move: " + pieces[28].attackedSquares[i][0] +","+ pieces[28].attackedSquares[i][1]);
                          if(allowMove(pieces[28].attackedSquares[i][0], pieces[28].attackedSquares[i][1], 28)){ 
                            println("king move is allowed for move: " + pieces[28].attackedSquares[i][0] +","+ pieces[28].attackedSquares[i][1]);
                               return true;
                          }
                        }
                   }
               }
           }
           else{printattackedsquaresfor(20);
               for ( int i=0; i<8; i++ ) {
                   if(pieces[20].attackedSquares[i][0] != -1){
                       if(moveIsValid(pieces[20].attackedSquares[i][0],pieces[20].attackedSquares[i][1], 20, false)){
                           if(allowMove(pieces[20].attackedSquares[i][0], pieces[20].attackedSquares[i][1], 20)){ 
                               return true;
                           }
                       }
                   }
               }
           }
        
           return false;
      }
       
//-------------------------------------------------------------------------------------------------
 //if i need to know
       public void printattackedsquaresfor(int pieceNum){
             for ( int i=0; i<21; i++ ) {
                    if (i>1 && pieces[pieceNum].attackedSquares[i][0] ==-1 ){      
                          i = 20; 
                    } else {
                          print(pieces[pieceNum].attackedSquares[i][0] + ",");
                          print(pieces[pieceNum].attackedSquares[i][1] + "; ");    
                    }
             } 
         
       }
//-------------------------------------------------------------------------------------------------------- 

//checkmate? check if all same color pieces can interrupt check
      public boolean isCheckmate(boolean white){
                 
                  int c,r =-1;
        
                  //white
                  if(white){
                       //loop for pieceNum
                       for(int k =8; k<32;k++){
                           //if black piece only 8-15,24-31
                           if(k<16 || k>23){
                                 //loop for moves
                                 for ( int i=0; i<21; i++ )  {
                                      c = pieces[k].attackedSquares[i][0];
                                      r = pieces[k].attackedSquares[i][1];
                                      //if c==-1 then end loop bc there is no more moves for this piece
                                      if (c ==-1 ){      
                                              i = 21; 
                                      }
                                      else if(moveIsValid(c,r, k , false)){
                                          
                                            if(allowMove(c, r, k)){
                                                println("This is not checkmate, move can be made by k;c,r ;" + k +";" + c +"," + r);
                                                return false;
                                            }
                                          
                                      }
                                 }
                           }
                       }
                       return true;
                  }  
                  //black
                  else{
                       //loop for pieceNum
                       for(int k =0; k<24;k++){
                           //white pieces only 0-7,16-23
                           if(k<8 || k>15){
                                 //loop for moves
                                 for ( int i=0; i<21; i++ )  {
                                      c = pieces[k].attackedSquares[i][0];
                                      r = pieces[k].attackedSquares[i][1];
                                      //if c==-1 then end loop bc there is no more moves for this piece
                                      if (c ==-1 ){      
                                              i = 21; 
                                      }
                                      else if(moveIsValid(c,r, k , false)){
                                          
                                            if(allowMove(c, r, k)){
                                                println("This is not checkmate, move can be made by k;c,r ;" + k +";" + c +"," + r);
                                                return false;
                                            }
                                          
                                      }
                                 }
                           }
                       }
                       return true;
                  }
      }
//-------------------------------------------------------------------------------------------------------- 

   //this method is used to see if move should be allowed after restrictions have been applied by moveIsValid
   //basically the tryMove method but does not actually do the move
       public boolean allowMove(int x,int y,int firstClickPN){
                   
                   boolean okToMove = false;
                   int pieceNum =-1;
                   //piece location x,y
                   int initialX = pieces[firstClickPN].getColumn();
                   int initialY =  pieces[firstClickPN].getRow();
                   
                   //move if not empty but do not kill yet
                   if(!isEmptyAt(x,y )){ 
                        pieceNum= getPieceNum(x , y ); 
                        pieces[pieceNum].end();  
                   }
                   
                   println("this is pieceNum  " + pieceNum);
                   pieces[firstClickPN].setRow(y);
                   pieces[firstClickPN].setColumn(x);
                   
                   //set kings x,y
                   if(pieces[firstClickPN].getType() == 6){
                        wkingx = pieces[20].getColumn();
                        wkingy = pieces[20].getRow();
                        bkingx = pieces[28].getColumn();
                        bkingy = pieces[28].getRow();
                   }
                   
                   //reset attacked squares bc some may have changed due to the move
                   setupAttackedSquaresForEachPiece();
                   
                   //if this is true then don't make move.. still in check
                   if (currentKingInCheck(pieces[firstClickPN].getPWhite())){
                          // println("allowMove, current king in check is true");
                         okToMove = false;
                   }
                   else{
                         //println("allowMove, current king in check is false");
                         okToMove = true;   
                   }
                   //reset pieces bc this is not a real move
                   pieces[firstClickPN].setRow(initialY);
                   pieces[firstClickPN].setColumn(initialX);
                   //reset attacked squares bc some may have changed due to the move
                   setupAttackedSquaresForEachPiece();
                   
                   if(pieces[firstClickPN].getType() == 6){
                        wkingx = pieces[20].getColumn();
                        wkingy = pieces[20].getRow();
                        bkingx = pieces[28].getColumn();
                        bkingy = pieces[28].getRow(); 
                   }
                   if(pieceNum != -1){
                        //pieceNum attacked needs it's life back
                        pieces[pieceNum].bringLife(); 
                   }                     
               return okToMove;
       }
//-------------------------------------------------------------------------------------------------------- 


       
//-------------------------------------------------------------------------------------------------------- 
   //this method is used after boolean moveIsValid approves of the restrictions for move and does several checks for the move
       public void tryMove(int x,int y,int firstClickPN){
                   int pieceNumAttacked =-1;
                   //piece location x,y
                   int initialX = pieces[firstClickPN].getColumn();
                   int initialY =  pieces[firstClickPN].getRow();
                   int tp = -1;
                   
                   //move if not empty but do not kill yet
                   if(!isEmptyAt(x,y )){ 
                        pieceNumAttacked = getPieceNum(x , y ); 
                        pieces[pieceNumAttacked].end();  
                   }else if(enPassant){
                        pieceNumAttacked = moveKeeper[moveCounter-1].piecenumber;
                        pieces[pieceNumAttacked].end();
                        enPassant = false;
                   }
                   println("this is pieceNumAttacked" + pieceNumAttacked);
                   
                   pieces[firstClickPN].setRow(y);
                   pieces[firstClickPN].setColumn(x);
                   
                   //set kings x,y
                   if(pieces[firstClickPN].getType() == 6){
                        wkingx = pieces[20].getColumn();
                        wkingy = pieces[20].getRow();
                        bkingx = pieces[28].getColumn();
                        bkingy = pieces[28].getRow();
                   }
                   
                   //reset attacked squares bc some may have changed due to the move
                   setupAttackedSquaresForEachPiece();
                   
                   //if this is true then don't make move.. still in check
                   if (currentKingInCheck(whiteTurn)){
                             //reset changed values from above
                             pieces[firstClickPN].setRow(initialY);
                             pieces[firstClickPN].setColumn(initialX);
                             //reset attacked squares bc some may have changed due to the move
                             setupAttackedSquaresForEachPiece();
                             
                             if(pieces[firstClickPN].getType() == 6){
                                  wkingx = pieces[20].getColumn();
                                  wkingy = pieces[20].getRow();
                                  bkingx = pieces[28].getColumn();
                                  bkingy = pieces[28].getRow(); 
                             }
                             if(pieceNumAttacked != -1){
                                  //pieceNum attacked needs it's life back
                                  pieces[pieceNumAttacked].bringLife();
                                  
                                   println("pieceNumAttacked:  \" \"" + pieceNumAttacked);
                                  //pieces[pieceNumAttacked].setRow(y);
                                  //pieces[pieceNumAttacked].setColumn(x);  
                             }
                   }
                   else{
                            if(inCheck(firstClickPN) && firstClickPN != -1){
                                  showCheck = true;
                                  if (!canKingMove(whiteTurn)){
                                      //if we are here, then the king cannot move and he is in check
                                      println("king cannot move!!!!!!!");
                                      if(isCheckmate(whiteTurn)){
                                          showCheck = false;
                                          display("Checkmate!");
                                          println("checkmate");
                                          //text("Checkmate", (8*squSize)+5, (7*squSize)+squSize/4, squSize, squSize/3 );
                                      }
                                  }
                                  else{
                                      display("King can Move");
                                  }
                             }else{
                                  showCheck = false; 
                             }
                             //move has been cleared through all checks so end captured piece
                             if ( pieceNumAttacked != -1){
                                  
                                        tp = pieces[pieceNumAttacked].getType();
                                        
                                        if (whiteTurn && tp != -1){
                                               if(tp ==1){
                                                   whitePoints = whitePoints + 1;
                                               } 
                                               else if(tp ==2){
                                                   whitePoints = whitePoints + 5;
                                               }
                                               else if(tp ==3){
                                                   whitePoints = whitePoints + 3;
                                               }
                                               else if(tp ==4){
                                                   whitePoints = whitePoints + 3;
                                               }
                                               else if(tp ==5){
                                                   whitePoints = whitePoints + 9;
                                               }
                                        }
                                        else{
                                              if(tp ==1){
                                                  blackPoints = blackPoints +1;
                                               } 
                                               else if(tp ==2){
                                                  blackPoints = blackPoints +5;
                                               }
                                               else if(tp ==3){
                                                  blackPoints = blackPoints +3;
                                               }
                                               else if(tp ==4){
                                                  blackPoints = blackPoints +3;
                                               }
                                               else if(tp ==5){
                                                  blackPoints = blackPoints +9;
                                               }
                                        }   
                                     
                                        //pieces[pieceNumAttacked].end(); 
                                        killCounter++;  
                                        
                             }    
                             println("piece set: x= " +mouseX/squSize+ "; y= "+ mouseY/squSize);
                             //store the move 
                             storeMove(firstClickPN,x,y,initialX,initialY, pieceNumAttacked); 
                             moveCounter++;
                             whiteTurn = !whiteTurn; 
                             pieces[firstClickPN].firstMove = false;
                   }
       }
//-------------------------------------------------------------------------------------------------------- 
       
       public void processMove(int x, int y){
         
                       //check if valid iff it's right color's turn
                       if(whiteTurn == pieces[firstClickPN].pWhite){
                                   //if the move is within the piece's restrictions
                                   if(moveIsValid(x,y, firstClickPN, true)){
                                         //attempt the move:
                                         tryMove(x,y, firstClickPN);
                                         //if flickOn is true then pawn needs promoted!
                                         if(pieces[firstClickPN].getFlickOn()){
                                             //turn flickOn off, then deal with promotion
                                             pieces[firstClickPN].setFlickOn(false);
                                             drawPromotionPieces();
                                             promotion = true; 
                                         }
                                         else{
                                           //need firstClickPieceNumber if promotion is on
                                             firstClickPN = -1;
                                         }
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
                                
                                   if (!whiteTurn){
                                       bw = "BLACK'S";
                                   }
                                   else{
                                       bw = "WHITE'S";
                                   }
                                   String mess =  bw + " TURN";
                                   display(mess); 
                                   firstClickPN = -1;
                       }
       }
//-------------------------------------------------------------------------------------------------------- 

       //called after a mouse click in Chess 
       public void mouseClicked() {
                
                //set up a clean text box:
                fill(150);
                stroke(225);
                rect( (8*squSize)+2, 2, squSize, squSize);
                          
                //destination x,y     
                int x = int(mouseX/squSize);
                int y = int(mouseY/squSize);
                int ybythree = int(mouseY/(squSize/3));
                println(int(mouseY/(squSize/3)));
                
                //this is a translate and rotate to change view for black
                if (!whiteTurn && !doPop){
                    pushMatrix();
                      // move the origin to the pivot point
                    translate(8*squSize, 8*squSize); 
      
                    // then pivot the grid
                    rotate(radians(180));
                    doPop = true;
                }
                if(doPop){
                   x = 7 - x;
                   y = 7 - y;
                } 
                
                //did user select to reset?
                if(resetOn == false && int(mouseX/squSize) == 8 && ybythree  == 22){
                         resetOn = true;
                }
                else if (int(mouseX/squSize) == 8  && ybythree  == 22){
                     reset(); 
                     resetOn= false;
                }
                else if (!booUndo && int(mouseX/squSize) == 8  && ybythree == 23){
                     booUndo = true;
                     println("click on undo");
                }
                else if (booUndo && int(mouseX/squSize) == 8   && ybythree == 23){
                     undoMove(); 
                     resetOn = false;
                     println("click on undo2");
                }
                else {
                     resetOn = false;
                     booUndo = false;
                }
                
                //need to check if a pawn has triggered flickOn in Piece, if so this click might b for promotion (else)
                if(!promotion && !resetOn && !booUndo){
                            
                              //reset attacked squares 
                              setupAttackedSquaresForEachPiece();
                                
                              //a piece has already been chosen, move piece?
                              if(firstClickPN != -1){
                                     processMove(x,y);
                                     println("------------------------");
                                     println("New click:");
                              }
                              //no piece present at x,y
                              else if(isEmptyAt(x,y)) {
                                    display("Empty Square");
                                    firstClickPN = -1;
                                    selx = -1;
                                    sely = -1;
                                    println("-------------------------");
                                    println("New click:");
                              } 
                              //piece is present at x,y; set as highlighted
                              else if(getPieceNum(x, y) != -1 && firstClickPN == -1 ){
                                    int pieceNumAttacked = getPieceNum(x , y );
                                    firstClickPN = pieceNumAttacked;
                                    selx = x;
                                    sely = y;
                                    println("-------------------------");
                                    println("New click:");
                              }//none of the above 
                              else{
                                    firstClickPN = -1;
                                    selx = -1;
                                    sely = -1;
                                    println("-------------------------");
                                    println("New click:");
                              }
                }
                //if promotion is set to true:
                else if (promotion){
                             
                              if(x == 8 && y == 2){
                                  pieces[firstClickPN].promote(2);
                                  promotion = false;
                                  firstClickPN = -1;
                                  selx = -1;
                                  sely = -1;
                              }
                              else if(x == 8 && y == 3){
                                  pieces[firstClickPN].promote(3);
                                  promotion = false;
                                  firstClickPN = -1;
                                  selx = -1;
                                  sely = -1;
                              }
                              else if(x == 8 && y == 4){
                                  pieces[firstClickPN].promote(4);
                                  promotion = false;
                                  firstClickPN = -1;
                                  selx = -1;
                                  sely = -1;
                              }
                              else if(x == 8 && y == 5){
                                  pieces[firstClickPN].promote(5);
                                  promotion = false;
                                  firstClickPN = -1;
                                  selx = -1;
                                  sely = -1;
                              }
                              if(promotion == false){
                                  //clear box:
                                  fill(0);
                                  stroke(0);
                                  rect( (8*squSize)+3, (1.5*squSize), squSize -6, 5*squSize);
                                
                              }
                }
                //this is a translate and rotate to change view for black
                
               if(doPop){
                  popMatrix(); 
                  doPop = !doPop;
               }         
               
       }
//-----------------------------------------------------------------------------------------------------

          
}

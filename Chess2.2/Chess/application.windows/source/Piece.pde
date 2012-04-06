//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


public class Piece extends PieceImages   
{
      //variables for a piece
      int pColumn, initialColumn;
      int pRow, initialRow;
      boolean pWhite, flickOn;
      boolean firstMove = true; 
      boolean pLive =true; 
      int pType, initialType, sqrSize; 
      int[][] attackedSquares = new int[21][2];
      int deathColumn =-1;
      int deathRow = -1;
      
      boolean didImageSetup = false;
      //PieceImages images;
      //constructor for dummy object:
      public Piece(int sqrsz){
           
           flickOn =false;
           pColumn = -1;
           pRow = -1;
           pWhite = true;
           pType = -1;
           initialType = -1;
           sqrSize = sqrsz;
           initialColumn = -1;
           initialRow = -1;
           
           setSquareSize(sqrsz);
           //images = new PieceImages(sqrsz);
      }
      //constructor
      public Piece( int column, int row, int type, int sqrsz, boolean isWhite ){
           pColumn = column;
           pRow = row;
           pWhite = isWhite;
           pType = type;
           initialType = type;
           sqrSize = sqrsz;
           initialColumn = column;
           initialRow = row;
           //super(sqrsz);
           setSquareSize(sqrsz);
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
               pColumn = column;
           }
       }
      
       void setRow(int row){
           if( pLive ){
                 if(pType ==1){
                    //check if the pawn has made it to an promotion setting, if so,
                    // then flickOn becomes true and is handled in Board
                    if (pWhite && row == 0){
                        flickOn = true;
                    }
                    else if(!pWhite && row == 7){
                        fill(255);
                        text("Promote Pawn:", 8*sqrSize+5, 3 , sqrSize, sqrSize );
                        flickOn = true;
                    }
                 } 
                 pRow = row;
           }
         
       }
       void promote(int type){
           pType = type;
       }
      
       void setType(int type){
           pType = type;
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
           deathRow = pRow;
           deathColumn = pColumn;
           pColumn = -1;
           pRow = -1;
       }
       void bringLife(){
           pLive = true;
           pType = initialType;
           if (deathRow != -1 && deathColumn != -1){
               pRow = deathRow;
               pColumn = deathColumn;
           }
       }
       public void resetPiece(){
           pLive = true;
           pType = initialType;
           pRow = getInity();
           pColumn = getInitx();
       }
       public void resetType(){
            pType = initialType; 
       }
       public int getDeathRow(){
            return deathRow; 
       }
       public int getDeathColumn(){
            return deathColumn; 
       }
       //get initial x for piece
       public int getInitx(){
           return initialColumn;
       }
       //get initial x for piece
       public int getInity(){
           return initialRow;
       }
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
//the next few methods are used to draw the piece r,b,n,k,q,p
  //these methods use parameters so a piece can be drawn anywhere     
       void drawBishop(int i, int j){
              
              if(pWhite){
                  image(whitebishop, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackbishop, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
      
       }
       void drawKing(int i, int j){
           
              if(pWhite){
                  image(whiteking, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackking, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
       }
       void drawKnight(int i, int j){
         
              if(pWhite){
                  image(whiteknight, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackknight, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
      
       }
       void drawPawn(int i, int j){
              if(pWhite){
                  image(whitepawn, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackpawn, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
    
       }
       void drawQueen(int i, int j){
         
              if(pWhite){
                  image(whitequeen, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackqueen, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
       }
       void drawRook(int i, int j){
              if(pWhite){
                  image(whiterook, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }else{
                  image(blackrook, i*sqrSize + sqrSize/15, j*sqrSize + sqrSize/15);
              }
       }
       
       
       //find which piece type it is and draw it:
       void drawPiece(int sqrsz, int i, int j){
                //this checks if setup needs done for pieceimages
               if(!didImageSetup){
                  super.setup();
                  didImageSetup = true;
               }
               setSquareSize(sqrsz);
               
               if(pLive){
                   if(pType ==1){
                      drawPawn(i,j);
                   } 
                   else if(pType ==2){
                      drawRook(i,j);
                   }
                   else if(pType ==3){
                      drawKnight(i,j);
                   }
                   else if(pType ==4){
                      drawBishop(i,j);
                   }
                   else if(pType ==5){
                      drawQueen(i,j);
                   }
                   else if(pType ==6){
                      drawKing(i,j);
                   }
               }
         
       }
       
       //method for promotion, allows for drawing any piece
       //find which piece type it is and draw it:
       void drawAnyPiece(boolean white, int type, int sqrsz, int i, int j){
               if(!didImageSetup){
                  super.setup();
                   didImageSetup = true;
               }
               pWhite = white;
               pType = type;       
               setSquareSize(sqrsz);
               drawPiece(sqrsz, i,j);
               
       }
           
  }


//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


public class Piece    {
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
                        fill(255);
                        text("Promote Pawn:", (8*sqrSize)+3, (2*sqrSize-sqrSize/2)+5, sqrSize, sqrSize );
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
       void drawBishop(int sqrsz, int i, int j){
         
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_bishop.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_bishop.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
                 
               }
      
       }
       void drawKing(int sqrsz, int i, int j){
           
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_king.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_king.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
                 
               }
       }
       void drawKnight(int sqrsz, int i, int j){
         
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_knight.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_knight.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
                 
               } 
      
       }
       void drawPawn(int sqrsz, int i, int j){
       
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_pawn.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_pawn.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
                 
               }
    
       }
       void drawQueen(int sqrsz, int i, int j){
         
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_queen.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_queen.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
                 
               }
      
       }
       void drawRook(int sqrsz, int i, int j){
         
              PImage b = new PImage(sqrsz/3,sqrsz/2);
              if(pWhite){
                  b = loadImage("white_rook.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
              }else{
                  b = loadImage("black_rook.png");
                  b.resize(sqrsz-sqrsz/4,sqrsz-sqrsz/5);
                  image(b, i*sqrsz + sqrsz/15, j*sqrsz + sqrsz/15);
               }
          
       }
       
       
       //find which piece type it is and draw it:
       void drawPiece(int sqrsz, int i, int j){
                
             if(pLive){
                 if(pType ==1){
                    drawPawn(sqrsz,i,j);
                 } 
                 else if(pType ==2){
                    drawRook(sqrsz,i,j);
                 }
                 else if(pType ==3){
                    drawKnight(sqrsz,i,j);
                 }
                 else if(pType ==4){
                    drawBishop(sqrsz,i,j);
                 }
                 else if(pType ==5){
                    drawQueen(sqrsz,i,j);
                 }
                 else if(pType ==6){
                    drawKing(sqrsz,i,j);
                 }
             }
         
       }
       
       //method for promotion, allows for drawing any piece
       //find which piece type it is and draw it:
       void drawAnyPiece(boolean white, int type, int sqrsz, int i, int j){
               
               pWhite = white;
               pType = type;       
         
               drawPiece(sqrsz,i,j);
               
       }
           
  }

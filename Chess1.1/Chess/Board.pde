

public class Board {
  
       int check;
       Piece[] pieces = new Piece[32]; //never going to be more than 32
       boolean ok = false;    
       int oldx;
       int oldy;
       int whosTurn;
       boolean promotion;
       
   
       
           
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
         
      public void drawEmpty(int column, int row){
                   
           if( ((column + row) % 2) == 1){
              fill(color(255));
           }
           else{
              fill(color(0)); 
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
        
       void draw(){
               stroke(color(128));
               
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
       }
}
          


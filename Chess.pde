static int squareSize = 80;
Board board = new Board(squareSize);

void setup(){
 size( (8*squareSize)+2, (8*squareSize)+2 );
 background(0);
 smooth();
  
}
void draw(){
  
 board.draw();
 
 
  
}




static int squareSize = 100;
Board board = new Board(squareSize);

void setup(){
 size( (8*squareSize)+2, (8*squareSize)+2 );
 background(0);
 smooth(); 
 board.draw();
  
}
void draw(){
 
 if(mousePressed){
     board.mouseClicked();  
     board.draw();
 }
 
  
}


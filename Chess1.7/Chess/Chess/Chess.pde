//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


static int squareSize = 95;
Board board = new Board(squareSize);
int count =0;

void setup(){
     size( (9*squareSize)+5, (8*squareSize));
     background(0);
     smooth(); 
     fill(150);
     stroke(225);
     rect( (8*squareSize)+2, 2, squareSize, squareSize);
     board.setup();
     board.draw();
}
void draw(){
     if(mousePressed){ 
        
         board.mouseClicked(); 
         board.draw(); 
         count++;
         
     }
  
}


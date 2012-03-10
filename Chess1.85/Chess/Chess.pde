//Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


static int squareSize = 100;
Board board = new Board(squareSize);
int count =0;

void setup(){
     //frameRate(30);
     size( (9*squareSize)+5, (8*squareSize));
     background(0);
     smooth(); 
     board.setup();
     board.draw();
     //put transparent cover welcome screen
     fill(5,5,0,225);
     rect( 0, 0,8*squareSize, 8*squareSize);
     //so the board is drawn for the background but if mode not selected then dont draw
     board.modeSelected = false;
     //create welcome box
     fill(0);
     rect(width/3,height/3,2*squareSize,2*squareSize);
     fill(25,25,225,50);
     rect(width/3, height/3 + squareSize ,squareSize,squareSize);
     fill(25,225,25,50);
     rect(width/3 + squareSize, height/3 + squareSize ,squareSize,squareSize);
     fill(255);
     textAlign(CENTER);
     text("Welcome To Chess in Processing\n", width/3,height/3,2*squareSize,squareSize );
     text(":-)\n1 Player", width/3, height/3 + squareSize ,squareSize,squareSize);
     text(":-) :-)\n2 Player", width/3 + squareSize, height/3 + squareSize ,squareSize,squareSize);
}
void draw(){
    
}
void mouseClicked(){
      board.mouseClicked(); 
      board.draw(); 
      count++;
      println("\nClick Number: " + count);
}

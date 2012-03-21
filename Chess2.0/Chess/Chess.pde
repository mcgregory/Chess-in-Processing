 //Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


      static int squareSize = 90;
      Board board = new Board(squareSize);
      int count =0;
      
      void setup(){
           //frameRate(30);
           size( (9*squareSize)+5, (8*squareSize));
           background(0);
           smooth(); 
           board.setup();
           board.draw();
           //so the board is drawn for the background but if mode not selected then dont draw
           board.modeSelected = false;
           //create welcome box
           board.drawStartup();
      }
      void draw(){
          
      }
      void mouseClicked(){
            board.mouseClicked(); 
            board.draw(); 
            count++;
            println("\nClick Number: " + count);
      }


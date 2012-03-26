 //Chess in Processing 
//Senior Project
//2011-2012
//by Monte Cruz Gregory


      static int squareSize = 90;
      Board board = new Board(squareSize);
      int count =0;
      PImage wood;
      
      void setup(){
        
           size( (9*squareSize)+squareSize/2 ,(8*squareSize)+squareSize/2);
           //rect(0,0,(9*squareSize)+35, (8*squareSize)+30);
           
           //frameRate(30);
           //background(200,200,0);
           wood = loadImage("images/texture.png");
           wood.resize(width/2,height/2);
           
           strokeWeight(3); 
           stroke(255);
           background(0);
           textAlign(CENTER);
           smooth(); 
           setupBackgroundTexture();
         pushMatrix();
         translate(squareSize/4, squareSize/4);
           board.setup();
           board.draw();

           //so the board is drawn for the background but if mode not selected then dont draw
           board.modeSelected = false;
           //create welcome box
           board.drawStartup();
           
         popMatrix();
      }
      void draw(){
        
      }
      void mouseClicked(){
            
             pushMatrix();
             translate(squareSize/4, squareSize/4);
              board.mouseClicked(); 
              board.draw(); 
              count++;
              println("\nClick Number: " + count);
            
             popMatrix();
      }
      void setupBackgroundTexture(){
            
           image(wood, 0,0);
           image(wood, width/2, height/2);
           image(wood, 0, height/2);
           image(wood, width/2,0); 
        
      }


import processing.net.*;

import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context
Minim sondofbomb;

AudioPlayer playerb;


Server s; 

//Client c1;
Client c1;
Client c;
Client c2;
Client c3;

board b = new board(1);
String input;
float data[];
boolean gameInProgresses = true;
int numOfPlayers = 0;

void setup() { 
  size(500, 500);
  background(255);
  stroke(0);
  //frameRate(10); 

  b.loadImages(loadImage("rock.png"), loadImage("players.png"), loadImage("bomb r.png"), loadImage("bomb b.png"), loadImage("explode.png"));

  s = new Server(this, 12345);


  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 2048);
  player.play();

  sondofbomb = new Minim(this);
  playerb = sondofbomb.loadFile("explosion sound.wav", 2048);
  //playerb.play();
}

void draw() {
  if (numOfPlayers<2) {//wait for start of game and all clients connect
    //numOfPlayers++;
    //s.write(b.sendAll() + "\n");
  } else {
    if (gameInProgresses == true) {
      if (b.gameOver()==true) {
        //b=null;
        b.endGame();
        gameInProgresses = false;
      } else {
        if (b.update()==1) {
          // b.show();
          playerb = sondofbomb.loadFile("explosion sound.wav", 2048);
          playerb.play();
        }
        // if (floor(random(10))==0)
        s.write(b.sendAll() + "\n");
        //else
      }

      try {//client c or c1
        //c = s.available();
        if (c != null) {
          input = c.readString(); 
          input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
          data = float(split(input, ' '));
          // println(data[1]);
          for (int i=0; i<data.length; i+=4) { 
            // println(data[i]);
            if (data[i]==999) {
              b.filler((int)data[i+1], (int)data[i+2], (int)data[i+3]);
              println("this should not happen");
            } else if (data[i]==998) {
              b.movePlayer((int)data[i+1], (int)data[i+2], (int)data[i+3]);
            } else if (data[i]==897) {
              b.placeBomb((int)data[i+1], (int)data[i+2]);
              i--;
            }
          }
        }
      }
      catch(RuntimeException e) {
      }


      try {//client c or c1
        //c = s.available();
        if (c2 != null) {
          input = c2.readString(); 
          input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
          data = float(split(input, ' '));
          // println(data[1]);
          for (int i=0; i<data.length; i+=4) { 
            // println(data[i]);
            if (data[i]==999) {
              b.filler((int)data[i+1], (int)data[i+2], (int)data[i+3]);
              println("this should not happen");
            } else if (data[i]==998) {
              b.movePlayer((int)data[i+1], (int)data[i+2], (int)data[i+3]);
            } else if (data[i]==897) {
              b.placeBomb((int)data[i+1], (int)data[i+2]);
              i--;
            }
          }
        }
      }
      catch(RuntimeException e) {
      }

      try {//client c or c1
        //c = s.available();
        if (c1 != null) {
          input = c1.readString(); 
          input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
          data = float(split(input, ' '));
          // println(data[1]);
          for (int i=0; i<data.length; i+=4) { 
            // println(data[i]);
            if (data[i]==999) {
              b.filler((int)data[i+1], (int)data[i+2], (int)data[i+3]);
              println("this should not happen");
            } else if (data[i]==998) {
              b.movePlayer((int)data[i+1], (int)data[i+2], (int)data[i+3]);
            } else if (data[i]==897) {
              b.placeBomb((int)data[i+1], (int)data[i+2]);
              i--;
            }
          }
        }
      }
      catch(RuntimeException e) {
      }


      try {//client c or c1
        //c = s.available();
        if (c3 != null) {
          input = c3.readString(); 
          input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
          data = float(split(input, ' '));
          // println(data[1]);
          for (int i=0; i<data.length; i+=4) { 
            // println(data[i]);
            if (data[i]==999) {
              b.filler((int)data[i+1], (int)data[i+2], (int)data[i+3]);
              println("this should not happen");
            } else if (data[i]==998) {
              b.movePlayer((int)data[i+1], (int)data[i+2], (int)data[i+3]);
            } else if (data[i]==897) {
              b.placeBomb((int)data[i+1], (int)data[i+2]);
              i--;
            }
          }
        }
      }
      catch(RuntimeException e) {
      }
    } else {
      s.write("111 " + b.findPlayerLeft() + "\n");
      background(0);
      fill(255, 255, 255);
      textSize(70); 
      textAlign(CENTER);
      //text("Game Over! Player "+ b.findPlayerLeft() +"Wins!", 250, 250);
      // text("Game Over! Player "+ b.findPlayerLeft() +"Wins!", 250, 250);
      text("Game Over!", 250, 150);
      if (b.findPlayerLeft() != -100) {
        text(" Player "+ b.findPlayerLeft() +" Wins!", 250, 250);
      }
      textSize(35);
      text("Click to start a new game", 250, 450);
      if (mousePressed == true) {
        gameInProgresses = true;
        b.startGame(numOfPlayers);
        s.write("119 " + "\n");
      }
    }
  }
}


void serverEvent(Server someServer, Client someClient) {
  println("New client: " + someClient.ip());
  numOfPlayers++;
  if (numOfPlayers==1) {
    c=someClient;
    b.addPlayer(numOfPlayers);
  } else if (numOfPlayers==2) {
    c1=someClient;
    b.addPlayer(numOfPlayers);
  } else if (numOfPlayers==3) {
    c2=someClient;
    b.addPlayer(numOfPlayers);
  } else if (numOfPlayers==4) {
    c3=someClient;
    b.addPlayer(numOfPlayers);
  }
  s.write("19 "+numOfPlayers+" "+"\n");
  // s.write(b.sendAll() + "\n");
}


void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
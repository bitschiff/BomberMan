import processing.net.*;
import ddf.minim.*;
import controlP5.*;



public ControlP5 cp5;

public AudioPlayer player;
public Minim minim;//audio context
public Minim sondofbomb;
public AudioPlayer playerb;



public Client c;
public board b = new board();
public String input;
public float data[];
public int playerNum = 0;

public Textfield myTextfield;

public boolean ipornot = false;


public String ipAdr= "192.168.1.156";

public void setup() { 
  size(500, 500);
  background(0);
  stroke(0);


  b.loadImages(loadImage("rock.png"), loadImage("players.png"), loadImage("bomb r.png"), loadImage("bomb b.png"), loadImage("explode.png"));

  cp5 = new ControlP5(this);



  myTextfield =  cp5.addTextfield("IP Address")
    .setPosition(width/2-100, height/2-20)
    .setSize(200, 40)

    .setFocus(true)
    .setColor(color(255, 0, 0))
    //.setAutoClear(false)
    ;

  cp5.addButton("submit", 0, 310, 200, 60, 20);


  // ipAdr = cp5.get(Textfield.class, "IP Address").getText();
  // c = new Client(this, ipAdr, 12345);
  // cp5.get(Textfield.class, "IP Address").hide();



  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 2048);
  player.play();


  sondofbomb = new Minim(this);
  playerb = sondofbomb.loadFile("explosion sound.wav", 2048);
} 

public void submit(int theValue) {
  ipAdr = cp5.get(Textfield.class, "IP Address").getText();
  c = new Client(this, ipAdr, 12345);
  //  cp5.get(Textfield.class, "IP Address").hide();
  ipornot=true;
  cp5.setVisible(false);
}

public void draw() {  
  if (ipornot==true) {
    if (b.update()==1) {
      // b.show();
      println("sound");
      playerb = sondofbomb.loadFile("explosion sound.wav", 2048);
      playerb.play();
    }



    c.write(b.move(playerNum) + "\n");

    try {
      if (c.available() > 0) { 
        input = c.readString(); 
        input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
        data = float(split(input, ' '));
        // println(data[1]);
        for (int i=0; i<data.length; i+=4) { 
          // println(data[i]);
          if (data[i]==999) {
            b.filler((int)data[i+1], (int)data[i+2], (int)data[i+3]);
          } else if (data[i]==897) {
            //println();
            b.fillerItmes((int)data[i+1], (int)data[i+2], (int)data[i+3]);
          } else if (data[i]==19&&playerNum==0) {//set playernumber
            playerNum=(int)data[i+1];

            if (playerNum<=4) {
              println(data[i+1]);
            } else {
              println("Server full however you can still watch");
            }

            i--;
            i--;
          } else if (data[i]==111) {//set playernumber
            b.filler(0, 0, -54);
            background(0);
            fill(255, 255, 255);
            textSize(70);
            textAlign(CENTER);
            text("Game Over", 250, 150);
            if (playerNum == (int)data[i+1]) {
              text(" You Win!", 250, 250);
            } else if (data[i+1]!=-100) {
              text(" Player "+ (int)data[i+1] +" Wins!", 250, 250);
            }
            i--;
            i--;
          } else if (data[i]==119) {//set playernumber
            b.filler(0, 0, 0);
            i--;
            i--;
            i--;
          }
        }
      }
    }
    catch(RuntimeException e) {
    }
    //b.show();
  } else {
  }
}
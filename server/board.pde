//PIECES
//nothing 0
//rocks -1
//players 1-4


//ITEMS
//bomb 1-1000000

public class board {



  int pieces[][] = new int[10][10];
  int items[][] = new int[10][10];
  int oldP[][] = new int[10][10];
  int oldI[][] = new int[10][10];


  int row = pieces.length-1;
  int col = pieces[0].length-1;

  PImage rock;
  PImage players;
  PImage br;
  PImage bb;
  PImage explosion;

  boolean gameover=false;



  public board() {
  }

  public board(int l) {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        pieces[i][j] = 0;
        items[i][j] = 0;
      }
    }
    addRocks();

    // rock = loadImage("http://www.truaudio.com/media/catalog/product/cache/1/thumbnail/50x/9df78eab33525d08d6e5fb8d27136e95/r/k/rkd-sub-gy_1_1.png");
    // rock= r;
    //addPlayer(1);
    // addPlayer(2);
    // addPlayer(3);
    // addPlayer(4);
  }

  public void endGame() {
    gameover=true;
  }

  public void startGame(int playerNumbers) {
    gameover=false;

    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        pieces[i][j] = 0;
        items[i][j] = 0;
      }
    }
    addRocks();

    for (int j = 1; j<=playerNumbers; j++) {
      addPlayer(j);
    }
  }


  public void loadImages(PImage r, PImage p, PImage brr, PImage bbb, PImage ex) {
    rock=r;
    players=p;
    br=brr;
    bb=bbb;
    explosion = ex;
  }


  public int update() {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (items[i][j] >= 2 && items[i][j] <= 180 ) {
          items[i][j]--;
        } else if (items[i][j] == 1) {
          //items[i][j] = 260;
          explode(i, j);
        }
      }
    }
    return (show());
  }

  public String getIP(Client someClient) {
    String ip = someClient.ip();
    while (ip.indexOf ('.')>0) {
      ip=ip.substring(0, ip.indexOf('.'))+ip.substring(ip.indexOf('.')+1, ip.length());
      //ip=ip.substring(ip.indexOf('.')+1, ip.length());
    }
    return ip;
  }

  public boolean gameOver() {
    int dead = 0;
    if (findPlayerX(1)==-100) 
      dead++;
    if (findPlayerX(2)==-100) 
      dead++;
    if (findPlayerX(3)==-100) 
      dead++;
    if (findPlayerX(4)==-100) 
      dead++;

    if (dead >=3)
      return true;


    return false;
  }

  public boolean inBounds(int x, int y) {
    if (x<0 || x>row || y<0 || y>col) {
      return false;
    }
    return true;
  }

  public void explode(int i, int j) {
    if (inBounds(i+1, j)) {
      pieces[i+1][j]=0;
      items[i+1][j] = 260;
    }

    if (inBounds(i+1, j+1)) {
      //   pieces[i+1][j+1]=0;
    }

    if (inBounds(i, j+1)) {
      pieces[i][j+1]=0;
      items[i][j+1] = 260;
    }

    if (inBounds(i, j)) {
      pieces[i][j]=0;
      items[i][j] = 260;
    }

    if (inBounds(i-1, j-1)) {
      //  pieces[i-1][j-1]=0;
    }

    if (inBounds(i, j-1)) {
      pieces[i][j-1]=0;
      items[i][j-1] = 260;
    }

    if (inBounds(i-1, j)) {
      pieces[i-1][j]=0;
      items[i-1][j] = 260;
    }

    if (inBounds(i+1, j-1)) {      
      //  pieces[i+1][j-1]=0;
    }
  }


  public int show() {
    int data = 0;
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (pieces[i][j] == -1) {//rock
          fillSpot(i*50, j*50, 0, 0, 0);
          image(rock, i*50, j*50);
        } else if (pieces[i][j] == 0) {//nothing
          fillSpot(i*50, j*50, 0, 0, 0);
        } else if (pieces[i][j] == 1) {//p1
          fillSpot(i*50, j*50, 0, 0, 0);
          image(players, i*50, j*50, 50, 50, 0, 0, 189/2, 249/2);
        } else if (pieces[i][j] == 2) {//p2
          fillSpot(i*50, j*50, 0, 0, 0);
          image(players, i*50, j*50, 50, 50, 189/2, 0, 189, 249/2);
        } else if (pieces[i][j] == 3) {//p3
          fillSpot(i*50, j*50, 0, 0, 0);
          image(players, i*50, j*50, 50, 50, 0, 249/2, 189/2, 249);
        } else if (pieces[i][j] == 4) {//p4
          fillSpot(i*50, j*50, 0, 0, 0);
          image(players, i*50, j*50, 50, 50, 189/2, 249/2, 189, 249);
        }


        if (items[i][j] >= 1 && items[i][j] <= 180 ) {//rock
          if (items[i][j] % 50<=25) {//rock
            // fillCircle(i*50, j*50, 217, 217, 217);
            //fillSpot(i*50, j*50, 0, 0, 0);
            image(br, i*50, j*50, 50, 50, 0, 0, 256, 256);
          } else {
            // fillCircle(i*50, j*50, 92, 92, 92);
            // fillSpot(i*50, j*50, 0, 0, 0);
            image(bb, i*50, j*50, 50, 50, 0, 0, 256, 256);
          }
        } else if (items[i][j] >= 200 && items[i][j] <= 380 ) {
          image(explosion, i*50, j*50, 50, 50, 0, 0, 100, 100);
          items[i][j]=items[i][j]-2;
          if (items[i][j] == 258) {
            data = 1;

          } else if (items[i][j] == 200) {
            items[i][j] = 0;
          }
        }
      }
    }
    return data;
  }

  public void addRocks() {
    noiseSeed(floor(random(99999)));
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (noise(i, j)<=.51) {
          pieces[i][j] = -1;
        }
      }
    }
  } 

  public void addPlayer(int playerNum) {
    if ((pieces[0][0] >= 1 && pieces[0][0] <= 4)==false) {
      pieces[0][0] = playerNum;
      pieces[0][1] = 0;
      pieces[1][0] = 0;
    } else if ((pieces[row][col] >= 1 && pieces[row][col] <= 4)==false) {
      pieces[row][col] = playerNum;
      pieces[row-1][col] = 0;
      pieces[row][col-1] = 0;
    } else if ((pieces[row][0] >= 1 && pieces[row][0] <= 4)==false) {
      pieces[row][0] = playerNum;
      pieces[row][1] = 0;
      pieces[row-1][0] = 0;
    } else if ((pieces[0][col] >= 1 && pieces[0][col] <= 4)==false) {
      pieces[0][col] = playerNum;
      pieces[1][col] = 0;
      pieces[0][col-1] = 0;
    }
  }

  public int getSpot(int r, int c) {
    return pieces[r][c];
  }

  public void movePlayer(int playerNumb, int directionX, int directionY) {
    int spotX = findPlayerX(playerNumb);
    int spotY = findPlayerY(playerNumb);
    if (spotX+directionX<0||spotX+directionX>row||spotY+directionY<0||spotY+directionY>col) {
    } else {
      if (pieces[spotX+directionX][spotY+directionY] == 0) {//fliped for some reson
        pieces[spotX+directionX][spotY+directionY] = playerNumb;//fliped for some reson
        pieces[spotX][spotY] = 0;
      }
    }
  }


  public void placeBomb(int X, int Y) {
    if (items[X][Y] ==0)
      items[X][Y] = 180;
  }


  public void fillSpot(int x, int y, int r, int g, int b) {
    fill(r, g, b);
    rect(x, y, 50, 50);
  }

  public void fillCircle(int x, int y, int r, int g, int b) {
    fill(r, g, b);
    ellipseMode(CENTER);
    ellipse(x+25, y+25, 50, 50);
  }

  public void fillSpot(int x, int y, int type) {
    pieces[x][y]=type;
  }

  public int findPlayerX(int playerNum) {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (pieces[i][j] == playerNum) {
          return i;
        }
      }
    }
    return -100;
  }

  public int findPlayerLeft() {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (pieces[i][j] >=1 &&pieces[i][j] <=4) {
          return pieces[i][j];
        }
      }
    }
    return -100;
  }

  public int findPlayerY(int playerNum) {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (pieces[i][j] == playerNum) {
          return j;
        }
      }
    }
    return -100;
  }

  public String findChange() {
    /*
    String changedData = "";
     for (int i = 0; i<=row; i++) {
     for (int j = 0; j<=col; j++) {
     if (pieces[i][j] != oldP[i][j]) {
     if (pieces[i][j] != 1) {
     changedData += "999 "+i+" "+j+" "+pieces[i][j]+" ";
     }
     }
     }
     } 
     
     
     for (int i = 0; i<=row; i++) {
     for (int j = 0; j<=col; j++) {
     old[i][j] = pieces[i][j];
     }
     }   
     
     return changedData;
     */
    println("error find changes");
    return "ERROR";
  }

  public void filler(int x, int y, int type) {
    pieces[x][y]=type;
  }

  public String sendAll() {
    String changedData = "";
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        //if (pieces[i][j] != oldP[i][j]) {
        changedData += "999 "+i+" "+j+" "+pieces[i][j]+" ";
        changedData += "897 "+i+" "+j+" "+items[i][j]+" ";
        //}
      }
    } 


    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        oldP[i][j] = pieces[i][j];
        oldI[i][j] = items[i][j];
      }
    }   


    return changedData;
  }


  public String sendSome() {
    String changedData = "";
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (pieces[i][j] != oldP[i][j]) {
          changedData += "999 "+i+" "+j+" "+pieces[i][j]+" ";
          changedData += "897 "+i+" "+j+" "+items[i][j]+" ";
        }
      }
    } 


    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        oldP[i][j] = pieces[i][j];
        oldI[i][j] = items[i][j];
      }
    }   


    return changedData;
  }
}
//nothing 0
//rocks -1
//players 1-4


public class board {

  //ArrayList<parts> pieces = new ArrayList<parts>();
  int pieces[][] = new int[10][10];
  int items[][] = new int[10][10];
  int oldP[][] = new int[10][10];
  int oldI[][] = new int[10][10];

  int row = pieces.length-1;
  int col = pieces[0].length-1;

  int keyTime =0;
  String oldPress=null;


  PImage rock;
  PImage players;
  PImage br;
  PImage bb;
  PImage explosion;


  public board() {
  }

  public board(int l) {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        pieces[i][j] = 0;
      }
    }
    addRocks();
    // addPlayer(1);
    //addPlayer(2);
    // addPlayer(3);
    // addPlayer(4);
  }

  public void loadImages(PImage r, PImage p, PImage brr, PImage bbb, PImage ex) {
    rock=r;
    players=p;
    br=brr;
    bb=bbb;
    explosion = ex;
  }

  public String getIP(Client someClient) {
    String ip = someClient.ip();
    while (ip.indexOf ('.')>0) {
      ip=ip.substring(0, ip.indexOf('.'))+ip.substring(ip.indexOf('.')+1, ip.length());
      //ip=ip.substring(ip.indexOf('.')+1, ip.length());
    }
    return ip;
  }


  public int update() {
    return show();
  }

  public String move(int playerNum) {
    String data = "";
    if (keyTime>0) {
      keyTime--;
    }//oldPress
    if (keyTime==0) {
      if (keyPressed == true) {
        if (key == CODED) {
          if (keyCode == UP) {
            data = sendMove(playerNum, 0, -1);
            keyTime=6;
            // movePlayer(1, 0, -1);
          } else if (keyCode == DOWN) {
            data =  sendMove(playerNum, 0, 1);
            keyTime=6;
            // movePlayer(1, 0, 1);
          } else if (keyCode == LEFT) {
            data =  sendMove(playerNum, -1, 0);
            keyTime=6;
            //movePlayer(1, -1, 0);
          } else if (keyCode == RIGHT) {
            data = sendMove(playerNum, 1, 0);
            keyTime=6;
            //movePlayer(1, 1, 0);
          }
        } else {//if (key == 'z') {
          data = sendBomb(playerNum);
          //movePlayer(1, 1, 0);
        }
      } else if (oldPress !=null) {
        data=oldPress;
      }
      oldPress=null;
    } else if (keyTime<=0) {
      if (keyPressed == true) {
        if (key == CODED) {
          if (keyCode == UP) {
            oldPress = sendMove(playerNum, 0, -1);
            // keyTime=30;
            // movePlayer(1, 0, -1);
          } else if (keyCode == DOWN) {
            oldPress =  sendMove(playerNum, 0, 1);
            //keyTime=30;
            // movePlayer(1, 0, 1);
          } else if (keyCode == LEFT) {
            oldPress =  sendMove(playerNum, -1, 0);
            //keyTime=30;
            //movePlayer(1, -1, 0);
          } else if (keyCode == RIGHT) {
            oldPress = sendMove(playerNum, 1, 0);
            //keyTime=30;
            //movePlayer(1, 1, 0);
          }
        } else {//if (key == 'z') {
          oldPress = sendBomb(playerNum);
          //movePlayer(1, 1, 0);
        }
      }
    }
    return data;
  }

  public int show() {
    int data = 0;
    if (pieces[0][0] !=-54) {
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
              println("fire");
            } else if (items[i][j] == 200) {
              items[i][j] = 0;
            }
          }
        }
      }
    }
    return data;
  }

  public void fillerItmes(int X, int Y, int type) {
    //if (items[X][Y] ==0)
    items[X][Y] = type;
  }

  public void fillCircle(int x, int y, int r, int g, int b) {
    fill(r, g, b);
    ellipseMode(CENTER);
    ellipse(x+25, y+25, 50, 50);
  }

  public void addRocks() {
    for (int i = 0; i<=row; i++) {
      for (int j = 0; j<=col; j++) {
        if (floor(random(100))<=60) {
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

  public void fillSpot(int x, int y, int r, int g, int b) {
    fill(r, g, b);
    rect(x, y, 50, 50);
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

  public void filler(int x, int y, int type) {
    pieces[x][y]=type;
  }


  public String sendMove(int playerNumb, int directionX, int directionY) {
    String data = "";

    data+= "998 "+playerNumb+" "+directionX+" "+directionY+" ";

    return data;
  }

  public String sendBomb(int playerNumb) {
    int spotX = findPlayerX(playerNumb);
    int spotY = findPlayerY(playerNumb);
    String data = "";

    data+= "897 "+spotX+" "+spotY+" ";

    return data;
  }
}
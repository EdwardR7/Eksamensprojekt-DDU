class cars {

  int x, y;
  int retning;
  int indexY, indexX;

  cars(int x, int y) {
    indexX = x;
    indexY = y;

    this.x = round(x*Scale);
    this.y = round(y*Scale);
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, Scale, Scale);
  }

  void move() {
    try {
      indexX = x/Scale;
      indexY = y/Scale;
      collision[indexY][indexX] = true;
      int direction = round(random(4.9));

      execute(direction);
    } 
    catch(Exception e) {
    }

  }

  void execute(int type) {

    switch(type) {
      
      
//Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt den går hen i er et vejfelt
    case 1:
      if (indexX > 0 && !collision[indexY][indexX-1] && vejFelt[indexY][indexX-1].roadtile) {
        x-= Scale; //GO LEFT
        collision[indexY][indexX] = false;
      } 
      break;
    case 2:
      if (indexX < columns-1 && !collision[indexY][indexX+1] && vejFelt[indexY][indexX+1].roadtile) {
        x+= Scale; //GO RIGHT;
        collision[indexY][indexX] = false;
      }
      break;
    case 3: 
      if (indexY > 0 && !collision[indexY-1][indexX] && vejFelt[indexY-1][indexX].roadtile) {
        y-= Scale; // GO UP
        collision[indexY][indexX] = false;
      }
      break;
    case 4: 
      if (indexY < rows-1 &&!collision[indexY+1][indexX] && vejFelt[indexY+1][indexX].roadtile) {
        y+= Scale; // GO DOWN
        collision[indexY][indexX] = false;
      }
      break;
    }
  }
}

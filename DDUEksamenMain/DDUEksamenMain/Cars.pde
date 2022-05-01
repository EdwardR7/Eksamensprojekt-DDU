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
    stroke(1);
    rect(x, y, Scale, Scale);
  }

  void move() {
    try {
      indexX = round(x/Scale);
      indexY = round(y/Scale);
      collision[indexX][indexY] = true;
      //int direction = round(random(8.9));

      execute(vejFelt[indexX][indexY].retning); // faktisk kode
      //execute(direction);
    } 
    catch(Exception e) {
    }
  }

  void execute(int type) {

    switch(type) {
      //Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt allerede er optaget
    case 1:
      if (indexX > 0 && vejFelt[indexX-1][indexY].roadtile) {
        if (!collision[indexX-1][indexY]) {
          x-= Scale; //GO LEFT
          collision[indexX][indexY] = false;
        } else {
          queueCounter++;
        }
      } 
      break;
    case 2:
      if (indexX < rows-1 && vejFelt[indexX+1][indexY].roadtile) {
        if (!collision[indexX+1][indexY]) {
          x+= Scale; //GO RIGHT;
          collision[indexX][indexY] = false;
        } else {
          queueCounter++;
        }
      }
      break;
    case 3: 
      if (indexY > 0 && vejFelt[indexX][indexY-1].roadtile) {
        if(!collision[indexX][indexY-1]){
        y-= Scale; // GO UP
        collision[indexX][indexY] = false;
      } else {
          queueCounter++;
        }
      }
      break;
    case 4: 
      if (indexY < columns-1 && vejFelt[indexX][indexY+1].roadtile) {
        if(!collision[indexX][indexY+1]){
        y+= Scale; // GO DOWN
        collision[indexX][indexY] = false;
        }else {
          queueCounter++;
        }
      }
      break;
    case 5:
      if (indexX > 0 && indexY > 0 && vejFelt[indexX-1][indexY-1].roadtile) {
        if(!collision[indexX-1][indexY-1]){
        x-= Scale; //GO LEFT
        y-= Scale; // GO UP
        collision[indexX][indexY] = false;
      }else {
          queueCounter++;
        }
      }
      break;
    case 6:
      if (indexX > 0 && indexY < columns-1 && vejFelt[indexX-1][indexY+1].roadtile) {
        if(!collision[indexX-1][indexY+1]){
        x-= Scale; //GO LEFT
        y+= Scale; // GO DOWN
        collision[indexX][indexY] = false;
      }else {
          queueCounter++;
        }
      }
      break;
    case 7:
      if (indexX < rows-1 && indexY > 0 && vejFelt[indexX+1][indexY-1].roadtile) {
        if(!collision[indexX+1][indexY-1]){
        x+= Scale; //GO RIGHT;
        y-= Scale; // GO UP
        collision[indexX][indexY] = false;
      }else {
          queueCounter++;
        }
      }
      break;
    case 8:
      if (indexX < rows-1 && indexY < columns-1 && vejFelt[indexX+1][indexY+1].roadtile) {
        if(!collision[indexX+1][indexY+1]){
        x+= Scale; //GO RIGHT;
        y+= Scale; // GO DOWN
        collision[indexX][indexY] = false;
      }else {
          queueCounter++;
        }
      }
      break;
    }
  }
}

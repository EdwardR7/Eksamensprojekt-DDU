class cars {

  PVector location, velocity, acceleration;
  float topspeed;
  int retning;
  int indexY, indexX;
  boolean stop;

  cars(int x, int y) {
    indexX = x;
    indexY = y;

    location = new PVector(x*Scale, y*Scale);
    velocity = new PVector(0, 0);
    topspeed = 3;
  }

  void display() {
    fill(0, 0, 255);
    stroke(1);
    rect(location.x, location.y, Scale, Scale);
    try {
      fill(1);
      textAlign(CENTER, CENTER);
      text(vejFelt[indexX][indexY].retning, location.x+Scale/2, location.y+Scale/2);
      textAlign(CORNER);
    } 
    catch(Exception e) {
    }
  }

  void move() {
    try {
      indexX = round(location.x/Scale);
      indexY = round(location.y/Scale);
      collision[indexX][indexY] = true;
      //int direction = round(random(8.9));

      execute(vejFelt[indexX][indexY].retning); // faktisk kode
      //execute(direction);
    } 
    catch(Exception e) {
    }
  }

  void execute(int type) {

    PVector distination = new PVector(vejFelt[indexX][indexY].x, vejFelt[indexX][indexY].y);
    switch(type) {
      //Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt allerede er optaget  
    case 1:
      if (indexX > 0 && vejFelt[indexX-1][indexY].roadtile) {
        if (!collision[indexX-1][indexY]) {
          //Go Left
          stop = false;
          distination = new PVector(vejFelt[indexX-1][indexY].x, vejFelt[indexX-1][indexY].y);
        } else {
          stop = true;
        }
      } 
      break;
    case 2:
      if (indexX < rows-1 && vejFelt[indexX+1][indexY].roadtile) {
        if (!collision[indexX+1][indexY]) {
          // Go Right
          distination = new PVector(vejFelt[indexX+1][indexY].x, vejFelt[indexX+1][indexY].y);
        stop = false;
      } else {
          stop = true;
        }
      }
      break;
    case 3: 
      if (indexY > 0 && vejFelt[indexX][indexY-1].roadtile) {
        if (!collision[indexX][indexY-1]) {
          // GO UP
          distination = new PVector(vejFelt[indexX][indexY-1].x, vejFelt[indexX][indexY-1].y);
        stop = false;
      } else {
          stop = true;
        }
      }
      break;
    case 4: 
      if (indexY < columns-1 && vejFelt[indexX][indexY+1].roadtile) {
        if (!collision[indexX][indexY+1]) {
          // GO DOWN
          distination = new PVector(vejFelt[indexX][indexY+1].x, vejFelt[indexX][indexY+1].y);
        stop = false;
      } else {
          stop = true;
        }
      }
      break;
    case 5:
      if (indexX > 0 && indexY > 0 && vejFelt[indexX-1][indexY-1].roadtile) {
        if (!collision[indexX-1][indexY-1]) {
          //GO LEFT // GO UP
          distination = new PVector(vejFelt[indexX-1][indexY-1].x, vejFelt[indexX-1][indexY-1].y);
        stop = false;
      } else {
          stop = true;
        }
      }
      break;
    case 6:
      if (indexX > 0 && indexY < columns-1 && vejFelt[indexX-1][indexY+1].roadtile) {
        if (!collision[indexX-1][indexY+1]) {
          //GO LEFT // GO DOWN
          distination = new PVector(vejFelt[indexX-1][indexY+1].x, vejFelt[indexX-1][indexY+1].y);
        stop = false;
      } else {
          stop = true;
        }
      }
      break;
    case 7:
      if (indexX < rows-1 && indexY > 0 && vejFelt[indexX+1][indexY-1].roadtile) {
        if (!collision[indexX+1][indexY-1]) {
          //GO RIGHT; // GO UP
          distination = new PVector(vejFelt[indexX+1][indexY-1].x, vejFelt[indexX+1][indexY-1].y);
        stop = false;
      } else {
        stop = true;
          
        }
      }
      break;
    case 8:
      if (indexX < rows-1 && indexY < columns-1 && vejFelt[indexX+1][indexY+1].roadtile) {
        if (!collision[indexX+1][indexY+1]) {
          //GO RIGHT; // GO DOWN
          distination = new PVector(vejFelt[indexX+1][indexY+1].x, vejFelt[indexX+1][indexY+1].y);
        stop = false;
      } else {
        stop = true;
        }
      }
      break;
    }
    //Compute a vector that points to distination
    acceleration = PVector.sub(distination, location);
    // Set magnitude of acceleration
    if (!stop) {
      acceleration.setMag(1);
    } else {
      acceleration.setMag(0);
    }
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);

    collision[indexX][indexY] = false;
  }
}

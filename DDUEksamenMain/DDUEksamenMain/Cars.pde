class cars {

  PVector location, velocity, acceleration;
  float topspeed;
  int retning;
  int indexY, indexX;
  Road CurrentRoad;

  cars(int x, int y) {
    indexX = x;
    indexY = y;

    location = new PVector(x*Scale+Scale/2, y*Scale+Scale/2);
    velocity = new PVector(0, 0);
    topspeed = 3;
  }

  void display() {
    fill(0, 0, 255);
    stroke(1);
    rectMode(CENTER);
    rect(location.x, location.y, Scale, Scale);
    rectMode(CORNER);
    try {
      fill(1);
      textAlign(CENTER, CENTER);
      text(vejFelt[indexX][indexY].retning, location.x, location.y);
      textAlign(CORNER);
    } 
    catch(Exception e) {
    }
  }

  void move() {
    try {
      indexX = floor(location.x/Scale);
      indexY = floor(location.y/Scale);

      vejFelt[indexX][indexY].collision = true;

      execute(vejFelt[indexX][indexY].retning); // faktisk kode
    } 
    catch(Exception e) {
    }
  }

  void execute(int type) {

    PVector destination = null;
    if(vejFelt[indexX][indexY].roadtile){
    CurrentRoad = vejFelt[indexX][indexY];
    }
      switch(type) {
        //Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt allerede er optaget  
      case 1: // Go left
        destination = retning(indexX > 0, 
          vejFelt[indexX-1][indexY], 
          new PVector(vejFelt[indexX-1][indexY].x, vejFelt[indexX-1][indexY].y+(Scale/2))); 
        break;
      case 2: // go right
        destination = retning(indexX < rows-1, 
          vejFelt[indexX+1][indexY], 
          new PVector(vejFelt[indexX+1][indexY].x+Scale, vejFelt[indexX+1][indexY].y+(Scale/2)));

        break;
      case 3: // go up
        destination = retning(indexY > 0, 
          vejFelt[indexX][indexY-1], 
          new PVector(vejFelt[indexX][indexY-1].x+(Scale/2), vejFelt[indexX][indexY-1].y));

        break;
      case 4: // go down
        destination = retning(indexY < columns-1, 
          vejFelt[indexX][indexY+1], 
          new PVector(vejFelt[indexX][indexY+1].x+(Scale/2), vejFelt[indexX][indexY+1].y+Scale));

        break;
      case 5: // go up left
        destination = retning(indexX > 0 && indexY > 0, 
          vejFelt[indexX-1][indexY-1], 
          new PVector(vejFelt[indexX-1][indexY-1].x, vejFelt[indexX-1][indexY-1].y));

        break;
      case 6: // go down left
        destination = retning(indexX > 0 && indexY < columns-1, 
          vejFelt[indexX-1][indexY+1], 
          new PVector(vejFelt[indexX-1][indexY+1].x, vejFelt[indexX-1][indexY+1].y+Scale));

        break;
      case 7: // go up right
        destination = retning(indexX < rows-1 && indexY > 0, 
          vejFelt[indexX+1][indexY-1], 
          new PVector(vejFelt[indexX+1][indexY-1].x+Scale, vejFelt[indexX+1][indexY-1].y));

        break;
      case 8: // go down right
        destination = retning(indexX < rows-1 && indexY < columns-1, 
          vejFelt[indexX+1][indexY+1], 
          new PVector(vejFelt[indexX+1][indexY+1].x+Scale, vejFelt[indexX+1][indexY+1].y+Scale));
        break;
    }
    //Compute a vector that points to distination
    acceleration = PVector.sub(destination, location);
    // Set magnitude of acceleration
    acceleration.setMag(10);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);

    strokeWeight(3);
    stroke(1);
    line(location.x, location.y, destination.x, destination.y);
    strokeWeight(1);
    // Location changes by velocity
    location.add(velocity);

    if (CurrentRoad != vejFelt[floor(location.x/Scale)][floor(location.y/Scale)] && vejFelt[floor(location.x/Scale)][floor(location.y/Scale)].roadtile) {
      vejFelt[indexX][indexY].collision = false;
    }
  }

  PVector retning(boolean border, Road road, PVector destination) {
      if (border && road.roadtile) {
        if (!road.collision) {
          return destination;
        }
      }
    return new PVector(CurrentRoad.x+Scale/2, CurrentRoad.y+Scale/2);
  }
}

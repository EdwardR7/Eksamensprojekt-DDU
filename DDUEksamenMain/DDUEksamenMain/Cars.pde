class cars {

  PVector location, velocity, acceleration;
  float topspeed;
  int retning;
  int indexY, indexX;
  Road CurrentRoad;
  Road Lyskrydsfelt;
  float rotateangle;
  color farve;
  int randomInt;

  cars(int x, int y) {
    indexX = x;
    indexY = y;

    location = new PVector(x*Scale+Scale/2, y*Scale+Scale/2);
    velocity = new PVector(0, 0);
    farve = (int) random(#000000);
    topspeed = 3;
  }

  void display() {

    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(rotateangle));
    fill(farve);
    stroke(1);
    rectMode(CENTER);
    rect(0, 0, Scale, Scale/2);
    fill(#89CFF0);
    rect(Scale/3, 0, Scale/4, Scale/2-Scale/8);
    rectMode(CORNER);
    popMatrix();
  }

  void move() {
    try {
      indexX = floor(location.x/Scale);
      indexY = floor(location.y/Scale);

      if (vejFelt[indexX][indexY].roadtile) {
        vejFelt[indexX][indexY].collision = true;
        CurrentRoad = vejFelt[indexX][indexY];
      }

      if (vejFelt[indexX][indexY].farve != color(255, 0, 0) && vejFelt[indexX][indexY].retning != 0) {
        execute(vejFelt[indexX][indexY].retning); // faktisk kode
      }

      if (vejFelt[indexX][indexY].farve == color(0, 255, 0)) {
        Lyskrydsfelt = vejFelt[indexX][indexY];
        randomInt = floor(random(1, 3.9));
      }

      if (vejFelt[indexX][indexY].retning == 0) {
        lyskrydslogic(Lyskrydsfelt.retning, randomInt);
      }
    }
    catch(Exception e) {
    }
  }

  void execute(int type) {
    switch(type) {
      //Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt allerede er optaget  
    case 1: // Go left
      velocity = retning(indexX > 0, 
        vejFelt[indexX-1][indexY], 
        new PVector(vejFelt[indexX-1][indexY].x, vejFelt[indexX-1][indexY].y+(Scale/2))); 
      break;
    case 2: // go right
      velocity = retning(indexX < rows-1, 
        vejFelt[indexX+1][indexY], 
        new PVector(vejFelt[indexX+1][indexY].x+Scale, vejFelt[indexX+1][indexY].y+(Scale/2)));

      break;
    case 3: // go up
      velocity = retning(indexY > 0, 
        vejFelt[indexX][indexY-1], 
        new PVector(vejFelt[indexX][indexY-1].x+(Scale/2), vejFelt[indexX][indexY-1].y));

      break;
    case 4: // go down
      velocity = retning(indexY < columns-1, 
        vejFelt[indexX][indexY+1], 
        new PVector(vejFelt[indexX][indexY+1].x+(Scale/2), vejFelt[indexX][indexY+1].y+Scale));

      break;
    case 5: // go up left
      velocity = retning(indexX > 0 && indexY > 0, 
        vejFelt[indexX-1][indexY-1], 
        new PVector(vejFelt[indexX-1][indexY-1].x, vejFelt[indexX-1][indexY-1].y));

      break;
    case 6: // go down left
      velocity = retning(indexX > 0 && indexY < columns-1, 
        vejFelt[indexX-1][indexY+1], 
        new PVector(vejFelt[indexX-1][indexY+1].x, vejFelt[indexX-1][indexY+1].y+Scale));

      break;
    case 7: // go up right
      velocity = retning(indexX < rows-1 && indexY > 0, 
        vejFelt[indexX+1][indexY-1], 
        new PVector(vejFelt[indexX+1][indexY-1].x+Scale, vejFelt[indexX+1][indexY-1].y));

      break;
    case 8: // go down right
      velocity = retning(indexX < rows-1 && indexY < columns-1, 
        vejFelt[indexX+1][indexY+1], 
        new PVector(vejFelt[indexX+1][indexY+1].x+Scale, vejFelt[indexX+1][indexY+1].y+Scale));
      break;
    }
    // Location changes by velocity
    location.add(velocity);

    if (CurrentRoad != vejFelt[floor(location.x/Scale)][floor(location.y/Scale)]) {
      vejFelt[CurrentRoad.indexX][CurrentRoad.indexY].collision = false;
    }
  }

  PVector retning(boolean border, Road road, PVector destination) {
    if (border && road.roadtile) {
      if (CurrentRoad.retning == 0) {
        velocity = calcVel(destination, Scale/2, topspeed/2);
        return velocity;
      }
      if (!road.collision && CurrentRoad.retning != 0) {
        velocity = calcVel(destination, Scale/2, topspeed/2); 
        return velocity;
      }
    }
    velocity = calcVel(null, Scale/Scale, 0.2);
    return velocity;
  }


  PVector calcVel(PVector destination, float acc, float velLimit) {
    //Compute a vector that points to distination
    acceleration = PVector.sub(destination, location);

    rotateangle = getAngle(location.x, location.y, destination.x, destination.y);
    // Set magnitude of acceleration
    acceleration.setMag(acc);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(velLimit);
    if (Check) {
      stroke(1);
      line(location.x, location.y, destination.x, destination.y);
      strokeWeight(1);
    }

    return velocity;
  }

  void lyskrydslogic(int type, int rd) {
    switch(type) {
    case 1:
      switch(rd) {
      case 1:
        if (indexX <= Lyskrydsfelt.indexX) {
          execute(1);
        }
        break;
      case  2: 
        if (indexX == Lyskrydsfelt.indexX-1) {
          execute(3);
        }
        break;
      case 3:
        if (indexX == Lyskrydsfelt.indexX-1) {
          execute(6);
        }
        if (indexX == Lyskrydsfelt.indexX-2) {
          execute(4);
        }
      }
      break;
    case 2:
      switch(rd) {
      case 1:
        if (indexX >= Lyskrydsfelt.indexX) {
          execute(2);
        }
        break;
      case  2: 
        if (indexX == Lyskrydsfelt.indexX+1) {
          execute(4);
        }
        break;
      case 3:
        if (indexX == Lyskrydsfelt.indexX+1) {
          execute(7);
        }
        if (indexX == Lyskrydsfelt.indexX+2) {
          execute(3);
        }
      }
      break;
    case 3:
      switch(rd) {
      case 1:
        if (indexY <= Lyskrydsfelt.indexY) {
          execute(3);
        }
        break;
      case  2: 
        if (indexY == Lyskrydsfelt.indexY-1) {
          execute(2);
        }
        break;
      case 3:
        if (indexY == Lyskrydsfelt.indexY-1) {
          execute(5);
        }
        if (indexY == Lyskrydsfelt.indexY-2) {
          execute(1);
        }
      }
      break;
    case 4:
      switch(rd) {
      case 1:
        if (indexY >= Lyskrydsfelt.indexY) {
          execute(4);
        }
        break;
      case  2: 
        if (indexY == Lyskrydsfelt.indexY+1) {
          execute(1);
        }
        break;
      case 3:
        if (indexY == Lyskrydsfelt.indexY+1) {
          execute(8);
        } 
        if (indexY == Lyskrydsfelt.indexY+2) {
          execute(2);
        }
      }
      break;
    }
  }
}

float getAngle(float pX1, float pY1, float pX2, float pY2) {
  return atan2(pY2 - pY1, pX2 - pX1)* 180/ PI;
}

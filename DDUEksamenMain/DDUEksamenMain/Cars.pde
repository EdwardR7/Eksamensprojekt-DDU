class cars {

  PVector location, velocity, acceleration;
  float topspeed;
  int retning;
  int indexY, indexX;
  Road CurretRoad;

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
      
      CurretRoad = vejFelt[indexX][indexY];
      vejFelt[indexX][indexY].collision = true;
      
      execute(vejFelt[indexX][indexY].retning); // faktisk kode
    } 
    catch(Exception e) {
    }
  }

  void execute(int type) {

    PVector destination = new PVector(vejFelt[indexX][indexY].x, vejFelt[indexX][indexY].y);
    switch(type) {
      //Tjekker om der er nogle inde for banen, om det er et vejfelt, og om det felt allerede er optaget  
    case 1:
      destination = retning(indexX > 0, 
        vejFelt[indexX-1][indexY],
        new PVector(vejFelt[indexX-1][indexY].x, vejFelt[indexX-1][indexY].y)); 

      break;
    case 2:
      destination = retning(indexX < rows-1, 
        vejFelt[indexX+1][indexY], 
        new PVector(vejFelt[indexX+1][indexY].x, vejFelt[indexX+1][indexY].y));

      break;
    case 3: 
      destination = retning(indexY > 0, 
        vejFelt[indexX][indexY-1],
        new PVector(vejFelt[indexX][indexY-1].x, vejFelt[indexX][indexY-1].y));

      break;
    case 4: 
      destination = retning(indexY < columns-1, 
        vejFelt[indexX][indexY+1],
        new PVector(vejFelt[indexX][indexY+1].x, vejFelt[indexX][indexY+1].y));

      break;
    case 5:
      destination = retning(indexX > 0 && indexY > 0, 
        vejFelt[indexX-1][indexY-1],
        new PVector(vejFelt[indexX-1][indexY-1].x, vejFelt[indexX-1][indexY-1].y));

      break;
    case 6:
      destination = retning(indexX > 0 && indexY < columns-1, 
        vejFelt[indexX-1][indexY+1],
        new PVector(vejFelt[indexX-1][indexY+1].x, vejFelt[indexX-1][indexY+1].y));

      break;
    case 7:
      destination = retning(indexX < rows-1 && indexY > 0, 
        vejFelt[indexX+1][indexY-1],
        new PVector(vejFelt[indexX+1][indexY-1].x, vejFelt[indexX+1][indexY-1].y));

      break;
    case 8:
      destination = retning(indexX < rows-1 && indexY < columns-1, 
        vejFelt[indexX+1][indexY+1],
        new PVector(vejFelt[indexX+1][indexY+1].x, vejFelt[indexX+1][indexY+1].y));

      break;
    }
    //Compute a vector that points to distination
    acceleration = PVector.sub(destination, location);
    // Set magnitude of acceleration
    acceleration.setMag(1);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
    
    if(CurretRoad != vejFelt[round(location.x/Scale)][round(location.y/Scale)]){
        vejFelt[indexX][indexY].collision = false;
      }
  }

  PVector retning(boolean border, Road road, PVector destination) {
    if (border && road.roadtile) {
      if (!road.collision) {
        return destination;
      }
    }
    velocity.limit(0);
    return new PVector(vejFelt[indexX][indexY].x, vejFelt[indexX][indexY].y);
  }
}

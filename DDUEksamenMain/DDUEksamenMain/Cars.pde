class cars {

  PVector location, velocity, acceleration;
  float topspeed;
  int retning;
  int indexY, indexX;
  Road CurrentRoad;
  float rotateangle;
  color farve;

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

      vejFelt[indexX][indexY].collision = true;
      
      if(vejFelt[indexX][indexY].retning ==9){
        
      } else{
      execute(vejFelt[indexX][indexY].retning); // faktisk kode
      }
    } 
    catch(Exception e) {
    }
  }

  void execute(int type) {

    if (vejFelt[indexX][indexY].roadtile) {
      CurrentRoad = vejFelt[indexX][indexY];
    }
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

    if (CurrentRoad != vejFelt[floor(location.x/Scale)][floor(location.y/Scale)] && vejFelt[floor(location.x/Scale)][floor(location.y/Scale)].roadtile) {
      CurrentRoad.collision = false;
    }
  }

  PVector retning(boolean border, Road road, PVector destination) {
    if (border && road.roadtile) {
      if (!road.collision) {
        velocity = calcVel(destination, Scale/2, topspeed/2); 
        return velocity;
      }
    }
    velocity = calcVel(new PVector(CurrentRoad.x+Scale/2, CurrentRoad.y+Scale/2), Scale/Scale, 0.2);
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
    if(Check){
    stroke(1);
    line(location.x, location.y, destination.x, destination.y);
    strokeWeight(1);
    }

    return velocity;
  }
}

float getAngle(float pX1, float pY1, float pX2, float pY2) {
  return atan2(pY2 - pY1, pX2 - pX1)* 180/ PI;
}

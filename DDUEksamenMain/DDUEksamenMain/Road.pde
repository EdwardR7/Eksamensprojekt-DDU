class Road {

  int x, y;
  int indexX, indexY;
  int retning;
  boolean roadtile;

  Road[] neighbors = new Road[4];

  Road(int x, int y, int retning, boolean roadtile) {
    this.x = round(x*Scale);
    this.y = round(y*Scale);
    this.retning = retning;
    this.roadtile = roadtile;

    indexX = x/Scale;
    indexY = y/Scale;
  }

  void display() {
    if(roadtile){
    fill(100, 100, 100);
    stroke(100);
    rect(x, y, Scale, Scale);
    }
  }

  void addNeighbors(){
    neighbors[1] = vejFelt[indexY][indexX-1]; // LEFT NEIGHBOR
    neighbors[2] = vejFelt[indexY][indexX+1]; // RIGHT NEIGHBOR
    neighbors[3] = vejFelt[indexY-1][indexX]; // TOP NEIGHBOR
    neighbors[4] = vejFelt[indexY+1][indexX]; // BOTTOM NEIGHBOR
}

}

class Road {

  int x, y;
  int indexX, indexY;
  int retning;
  boolean roadtile;

  //Vejlinjer
  PShape l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16;

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
    if (roadtile) {
      fill(100, 100, 100);
      stroke(75);
      rect(x, y, Scale, Scale);
      if (Check) {
        roadDirections();
      }
    }
  }

  void addNeighbors() {
    neighbors[1] = vejFelt[indexY][indexX-1]; // LEFT NEIGHBOR
    neighbors[2] = vejFelt[indexY][indexX+1]; // RIGHT NEIGHBOR
    neighbors[3] = vejFelt[indexY-1][indexX]; // TOP NEIGHBOR
    neighbors[4] = vejFelt[indexY+1][indexX]; // BOTTOM NEIGHBOR
  }

  void roadDirections() {
    stroke(255);
    
    //Alle Vejlinjer
    l1 = createShape(LINE, x, y+(Scale*1/2), x+Scale, y+(Scale*1/2));
    l2 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y);
    l3 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y+Scale);
    l4 = createShape(LINE, x+(Scale*1/2), y+Scale, x+Scale, y+(Scale*1/2));
    l5 = createShape(LINE, x+(Scale*1/2), y, x+Scale, y+(Scale*1/2));
    l6 = createShape(LINE, x+(Scale*1/2), y, x+(Scale*1/2), y+Scale);
    l7 = createShape(LINE, x, y, x+Scale, y+Scale);
    l8 = createShape(LINE, x, y, x+(Scale*1/4), y+(Scale*3/4));
    l9 = createShape(LINE, x, y, x+(Scale*3/4), y+(Scale*1/4));
    l10 = createShape(LINE, x, y+Scale, x+Scale, y);
    l11 = createShape(LINE, x, y+Scale, x+(Scale*1/4), y+(Scale*1/4));
    l12 = createShape(LINE, x, y+Scale, x+(Scale*3/4), y+(Scale*3/4));
    l13 = createShape(LINE, x+(Scale*1/4), y+(Scale*1/4), x+Scale, y);
    l14 = createShape(LINE, x+(Scale*3/4), y+(Scale*3/4), x+Scale, y);
    l15 = createShape(LINE, x+(Scale*3/4), y+(Scale*1/4), x+Scale, y+Scale);
    l16 = createShape(LINE, x+(Scale*1/4), y+(Scale*3/4), x+Scale, y+Scale);

    switch(retning) {
    case 1:
      shape(l1);
      shape(l2);
      shape(l3);
      break;
    case 2:
      shape(l1);
      shape(l4);
      shape(l5);
      break;
    case 3:
      shape(l6);
      shape(l2);
      shape(l5);
      break;
    case 4:
      shape(l6);
      shape(l3);
      shape(l4);
      break;
    case 5:
      shape(l7);
      shape(l8);
      shape(l9);
      break;
    case 6:
      shape(l10);
      shape(l11);
      shape(l12);
      break;
    case 7:
      shape(l10);
      shape(l13);
      shape(l14);
      break;
    case 8:
      shape(l7);
      shape(l15);
      shape(l16);
      break;
    }
  }
}

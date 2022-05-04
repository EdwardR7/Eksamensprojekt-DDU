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
    switch(retning) {
    case 1:
      l1 = createShape(LINE, x, y+(Scale*1/2), x+Scale, y+(Scale*1/2));
      shape(l1);

      l2 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y);
      shape(l2);

      l3 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y+Scale);
      shape(l3);
      break;

    case 2:
      l4 = createShape(LINE, x, y+(Scale*1/2), x+Scale, y+(Scale*1/2));
      shape(l4);

      l5 = createShape(LINE, x+(Scale*1/2), y+Scale, x+Scale, y+(Scale*1/2));
      shape(l5);

      l6 = createShape(LINE, x+(Scale*1/2), y, x+Scale, y+(Scale*1/2));
      shape(l6);
      break;
    case 3:
      l7 = createShape(LINE, x+(Scale*1/2), y, x+(Scale*1/2), y+Scale);
      shape(l7);

      l8 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y);
      shape(l8);

      l9 = createShape(LINE, x+(Scale*1/2), y, x+Scale, y+(Scale*1/2));
      shape(l9);
      break;
    case 4:
      l10 = createShape(LINE, x+(Scale*1/2), y, x+(Scale*1/2), y+Scale);
      shape(l10);

      l11 = createShape(LINE, x, y+(Scale*1/2), x+(Scale*1/2), y+Scale);
      shape(l11);

      l12 = createShape(LINE, x+(Scale*1/2), y+Scale, x+Scale, y+(Scale*1/2));
      shape(l12);
    break;
    case 5:
      l13 = createShape(LINE, x, y, x+Scale, y+Scale);
      shape(l13);

      l14 = createShape(LINE, x, y, x+(Scale*1/4), y+(Scale*3/4));
      shape(l14);

      l15 = createShape(LINE, x, y, x+(Scale*3/4), y+(Scale*1/4));
      shape(l15);
    break;
    case 6:
      l16 = createShape(LINE, x, y+Scale, x+Scale, y);
      shape(l16);

      l17 = createShape(LINE, x, y+Scale, x+(Scale*1/4), y+(Scale*1/4));
      shape(l17);

      l18 = createShape(LINE, x, y+Scale, x+(Scale*3/4), y+(Scale*3/4));
      shape(l18);
    break;
    case 7:
      l19 = createShape(LINE, x, y+Scale, x+Scale, y);
      shape(l19);

      l20 = createShape(LINE, x+(Scale*1/4), y+(Scale*1/4), x+Scale, y);
      shape(l20);

      l21 = createShape(LINE, x+(Scale*3/4), y+(Scale*3/4), x+Scale, y);
      shape(l21);
   break;
   case 8:
      l22 = createShape(LINE, x, y, x+Scale, y+Scale);
      shape(l22);

      l23 = createShape(LINE, x+(Scale*3/4), y+(Scale*1/4), x+Scale, y+Scale);
      shape(l23);

      l24 = createShape(LINE, x+(Scale*1/4), y+(Scale*3/4), x+Scale, y+Scale);
      shape(l24);
      break;
    }
  }
}

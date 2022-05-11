class Road {

  int x, y;
  int indexX, indexY;
  int retning;
  boolean roadtile;
  boolean collision;
  boolean lyskryds;
  color farve;
  int timer;

  //Vejlinjer
  PShape l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16;

  Road(int x, int y, int retning, boolean roadtile) {
    indexX = x;
    indexY = y;
    this.x = round(x*Scale);
    this.y = round(y*Scale);
    this.retning = retning;
    this.roadtile = roadtile;
    this.collision = false;
    farve = color(100, 100, 100);
    timer = 0;
  }

  void display() {
    if (roadtile) {
      fill(farve);
      stroke(75);
      rect(x, y, Scale, Scale);
      if (Check) {
        roadDirections();
      }
      if (retning == 9) {
        
        if (timer >= 5*frameRate) {
          farve = color(0, 255, 0);
          lyskryds = true;
          timer+=1;
          if (timer >= 10*frameRate){
            timer = 0;
          }
        } else {
          lyskryds = false;
          farve = color(255,0,0);
          timer+=1;

        }
      }
    }
  }

  void roadDirections() {
    stroke(255);

    vejLinjer();
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
  void vejLinjer() {
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
  }
}

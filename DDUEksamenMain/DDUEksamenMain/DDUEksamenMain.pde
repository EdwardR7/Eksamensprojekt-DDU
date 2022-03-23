
int Scale = 16; // size of each cell
int rows; // rows of board
int columns; // colums of board

boolean[][] vejFelt; //Vejfelter
boolean[][] collision; //Collisiondetection

boolean[] pressed = new boolean[256];

int x, y;

void setup() {
  size(800, 800);

  rows = round(width/Scale);
  columns = round(width/Scale);

  vejFelt = new boolean[rows][columns];
}


void draw() {
  vejFelt[15][12] = true;
  background(-1);
  drawGrid();
  move();

  fill(255, 0, 0);
  rect(x, y, Scale, Scale);

  for (int i = 0; i < rows-1; i++) {
    for (int j = 0; j < columns-1; j++) {
      if (vejFelt[i][j] == true) {
        fill(0, 255, 0);
        rect(i*Scale, j*Scale, Scale, Scale);
      }
    }
  }
}

void drawGrid() {
  // Begin loop for columns
  for (int i = 0; i < height; i+=Scale) {
    line(0, i, width, i);
  }
  // Begin loop for rows
  for (int i = 0; i < width; i+=Scale) {
    line(i, 0, i, height);
  }
}

void move() {
  if (pressed[65]) { /* A */
    if (x/Scale > 0) {
      x -= Scale;
    }
  }

  if (pressed[68]) { /* D */
    if (x/Scale < columns-1) {
      x += Scale;
    }
  }

  if (pressed[87]) { /* W */
    if (y/Scale > 0) {
      y-=Scale;
    }
  }

  if (pressed[83]) { /* S */
    if (y/Scale < rows-1) {
      y+=Scale;
    }
  }
}

void keyPressed() {
  pressed[keyCode] = true;
}

void keyReleased() {
  pressed[keyCode] = false;
}

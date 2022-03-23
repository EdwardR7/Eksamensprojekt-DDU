
int Scale = 16; // size of each cell
int rows; // rows of board
int columns; // colums of board

boolean[][] vejFelt; //Vejfelter
boolean[][] collision; //Collisiondetection

boolean[] pressed = new boolean[256];

int x, y;
ArrayList<cars> car;


void setup() {
  size(800, 800);

  rows = round(width/Scale);
  columns = round(width/Scale);

  vejFelt = new boolean[rows][columns];
  collision = new boolean[rows][columns];

  car = new ArrayList<cars>();

  for (int i = 0; i < 10; i++) {
    car.add(new cars(round(random(0, columns)), round(random(0, rows))));
  }
}


void draw() {
  vejFelt[15][12] = true;
  background(-1);
  drawGrid();
  for (cars c : car) {
    c.move();
    c.display();
  }

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


void keyPressed() {
  pressed[keyCode] = true;
}

void keyReleased() {
  pressed[keyCode] = false;
}

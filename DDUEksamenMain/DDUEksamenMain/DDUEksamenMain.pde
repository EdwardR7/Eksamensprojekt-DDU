import processing.serial.*;

import java.util.Map;
import java.nio.file.Paths;
import javafx.scene.input.MouseEvent;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.SceneAntialiasing;
import javafx.scene.canvas.Canvas;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import javafx.scene.control.*;
import processing.javafx.PSurfaceFX;
import javafx.collections.*;
import java.lang.Object.*;
import de.bezier.data.sql.*;
import java.security.*;

//Database
SQLite db;

int Scale = 16; // size of each cell
int rows; // rows of board
int columns; // colums of board

Road[][] vejFelt; //Vejfelter

ArrayList<cars> car;

int rot;
int tools;

int userID;

String message;
String logName;
String savedMap;

boolean Check = false;
boolean Logged = false;

ArrayList<String> mapContents = new ArrayList<String>();

PImage rImage;

int score;
int simtimer = 0;
boolean simstart = false;

Scene scene;
Stage stage;

DBMetoder DB = new DBMetoder(); //DBMetoder object til at kalde constructors fra databasemetoder

protected PSurface initSurface() {
  surface = (PSurfaceFX) super.initSurface();
  final Canvas canvas = (Canvas) surface.getNative();
  final Scene oldScene = canvas.getScene();
  final Stage stage = (Stage) oldScene.getWindow();
  surface.setTitle("Eksamensprojekt DDU");

  try {
    Platform.runLater(new Runnable() {
      @Override
        public void run() {
        try {
          stage.setScene(loginController(stage, canvas));
        }
        catch(Exception e) {
          println(e);
        }
      }
    }
    );
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  return surface;
}

void setup() {
  size(960, 560, FX2D); // FX2D bruger funktionen  initSurface()
  frameRate(60);
  db = new SQLite( this, "TrafikDB.db" );

  rows = round(width/Scale);
  columns = round(height/Scale);

  vejFelt = new Road[rows][columns];

  car = new ArrayList<cars>();

  for (int r = 0; r < rows; r++) {
    for (int R = 0; R < columns; R++) {
      vejFelt[r][R] = new Road(r, R, 9, false);
    }
  }
}

void draw() {

  background(50, 205, 50);
  drawGrid();

  for (int r = 0; r < rows; r++) {
    for (int R = 0; R < columns; R++) {
      vejFelt[r][R].display();
    }
  }
  for (cars c : car) {
    c.move();
    c.display();
  }


  try {
    if (tools == 1) {
      rImage.resize(50, 50);
    } 

    if (tools == 3) {      
      switch(rot) {
      case 1: 
        rImage.resize(32, 16);
        break;
      case 2: 
        rImage.resize(32, 32);

        break;
      case 3: 
        rImage.resize(16, 32);

        break;
      case 4: 
        rImage.resize(32, 32);

        break;
      }
    } 
    if (tools == 4) {
      rImage.resize(16, 16);
    }
    if (tools == 5) {
      rImage.resize(64, 64);
    }
    image(rImage, vejFelt[round(mouseX/Scale)][round(mouseY/Scale)].x, vejFelt[round(mouseX/Scale)][round(mouseY/Scale)].y);
  }
  catch(Exception e) {
  }
  fill(1);
  text(frameRate, 20, 20);
  
  if (simstart) {
    if (simtimer > 1200) {
      simstart = false;
      car.clear();
      for (int r = 0; r < rows; r++) {
        for (int R = 0; R < columns; R++) {
          vejFelt[r][R].collision = false;
        }
      }
    } else {
      simtimer++;
    }
  }
  text("Simulation score: " + score/100, 20, 40);
}

void drawGrid() {
  stroke(34, 139, 34);
  // Begin loop for columns
  for (int i = 0; i < height; i+=Scale) {
    line(0, i, width, i);
  }
  // Begin loop for rows
  for (int i = 0; i < width; i+=Scale) {
    line(i, 0, i, height);
  }
}

void mouseClicked() {
  try {
    RoadPieces roadPiece = new RoadPieces();
    switch(tools) { //Corner roadpiece
    case 1:
      roadPiece.Corners();
      break;
    case 2: //Insert car
      if (vejFelt[round(mouseX/Scale)][round(mouseY/Scale)].roadtile) {
        car.add(new cars(round(mouseX)/Scale, round(mouseY)/Scale));
      }
      break;
    case 3://doubleRoadpiece
      roadPiece.doubleRoad();
      break;
    case 4://singleRoadpiece
      roadPiece.singleRoad();
      break;
    case 5://singleRoadpiece
      roadPiece.traficlights();
      break;
    case 6:
      vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 9, false, false, 0);
      break;
    }
  }
  catch( Exception e) {
  }
}

void displayCursorImage() {
  switch (tools) {
  case 1:  
    switch(rot) {
    case 1: 
      rImage = loadImage("UpRight.PNG");
      break;
    case 2: 
      rImage = loadImage("UpLeft.PNG");
      break;
    case 3: 
      rImage = loadImage("DownLeft.PNG");
      break;
    case 4: 
      rImage = loadImage("DownRight.PNG");
      break;
    }
    break;
  case 2:
    rImage = null;
    break;

  case 3:
    switch(rot) {
    case 1: 
      rImage = loadImage("dHorizontal.png");
      break;
    case 2: 
      rImage = loadImage("dDiagonal1.png");
      break;
    case 3: 
      rImage = loadImage("dVertical.png");
      break;
    case 4: 
      rImage = loadImage("dDiagonal2.png");
      break;
    }
    break;

  case 4:
    switch(rot) {
    case 1: 
      rImage = loadImage("sUP.png");
      break;
    case 2: 
      rImage = loadImage("sUPRIGHT.png");
      break;
    case 3: 
      rImage = loadImage("sRIGHT.png");
      break;
    case 4: 
      rImage = loadImage("sDOWNRIGHT.png");
      break;
    case 5: 
      rImage = loadImage("sDOWN.png");
      break;
    case 6: 
      rImage = loadImage("sDOWNLEFT.png");
      break;
    case 7: 
      rImage = loadImage("sLEFT.png");
      break;
    case 8: 
      rImage = loadImage("sUPLEFT.png");
      break;
    }
    break;

  case 5:
    rImage = loadImage("Lyskryds.png");
    break;
  case 6:
    rImage = null;

  default:
    rImage = null;
    break;
  }
}

void rotateRight() {
  rot += 1;
  if (tools == 4 && rot > 8) {
    rot=1;
  } else if (tools != 4 && rot > 4) {
    rot = 1;
  }
}
void rotateLeft() {
  rot -= 1;
  if (rot<1) {
    if (tools == 4) {
      rot = 8;
    } else {
      rot = 4;
    }
  }
}

float getAngle(float pX1, float pY1, float pX2, float pY2) {
  return atan2(pY2 - pY1, pX2 - pX1)* 180/ PI;
}

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

int rot1;
int rot2;
int rot3;
int tools;

int userID;

String message;
String logName;
String savedMap;

boolean Check = false;
boolean Logged = false;

ArrayList<String> mapContents = new ArrayList<String>();

PImage rImage;

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
  fill(1);
  text(frameRate, 20, 20);

  try {
    if (tools == 1) {
      rImage.resize(50, 50);
       image(rImage, vejFelt[round(mouseX/Scale)][round(mouseY/Scale)].x, vejFelt[round(mouseX/Scale)][round(mouseY/Scale)].y);
    }
  }
  catch(Exception e) {
  }
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
    }
  }
  catch( Exception e) {
  }
}

void displayCursorImage() {
  switch (tools) {
  case 1:
    switch(rot1) {
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
  }
}

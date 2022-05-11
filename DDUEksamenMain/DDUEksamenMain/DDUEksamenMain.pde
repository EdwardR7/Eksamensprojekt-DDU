import java.util.Map;
import java.nio.file.Paths;
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

String message;

boolean Check = false;

PImage rImage;

Scene scene;
Stage stage;

protected PSurface initSurface() {
  surface = (PSurfaceFX) super.initSurface();
  final Canvas canvas = (Canvas) surface.getNative();
  final Scene oldScene = canvas.getScene();
  final Stage stage = (Stage) oldScene.getWindow();
  surface.setTitle("Eksamensprojekt DDU");
  surface.setResizable(false);


  try {
    Platform.runLater(new Runnable() {
      @Override
        public void run() {
        try {
          stage.setScene(menuController(stage, canvas));
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
      vejFelt[r][R] = new Road(r, R, 0, false);
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
      image(rImage, mouseX, mouseY);
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
  switch(tools) { //Corner roadpiece
  case 1:
    try {
      RoadPieces roadPiece = new RoadPieces();
      roadPiece.Corners();
    }
    catch( Exception e) {
    }
    break;
  case 2: //Insert car
    try {
      car.add(new cars(round(mouseX)/Scale, round(mouseY)/Scale));
    }
    catch( Exception e) {
    }
    break;

  case 3://doubleRoadpiece
    try {
      RoadPieces roadPiece = new RoadPieces();
      roadPiece.doubleRoad();
    }
    catch( Exception e) {
    }
    break;

  case 4://singleRoadpiece
    try {
      RoadPieces roadPiece = new RoadPieces();
      roadPiece.singleRoad();
    }
    catch( Exception e) {
    }

    break;
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

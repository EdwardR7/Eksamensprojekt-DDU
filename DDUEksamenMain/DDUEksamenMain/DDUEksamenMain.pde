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

int Scale = 16; // size of each cell
int rows; // rows of board
int columns; // colums of board

Road[][] vejFelt; //Vejfelter

ArrayList<cars> car;

int rot1;
int rot2;
int rot3;
int tools;

boolean Check = false;

PImage rImage;

//Vejlinjer

int queueCounter;

protected PSurface initSurface() {
  surface = (PSurfaceFX) super.initSurface();
  final Canvas canvas = (Canvas) surface.getNative();
  final Scene oldScene = canvas.getScene();
  final Stage stage = (Stage) oldScene.getWindow();

  try {
    FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Scene.fxml").toUri().toURL()); // abs path to fxml file

    final Parent sceneFromFXML = loader.load();
    final Map<String, Object> namespace = loader.getNamespace();
    final Scene newScene = new Scene(sceneFromFXML, stage.getWidth(), stage.getHeight(), false, SceneAntialiasing.BALANCED);

    final Button b1 = (Button) namespace.get("butt1"); // get element by fx:id  //insert corners
    final Button b2 = (Button) namespace.get("butt2"); // get element by fx:id  //insert corners ROTATE LEFT
    final Button b3 = (Button) namespace.get("butt3"); // get element by fx:id  //insert corners ROTATE RIGHT
    final Button b4 = (Button) namespace.get("butt4"); // get element by fx:id //insert cars

    final Button b5 = (Button) namespace.get("butt5"); // get element by fx:id  //insert DoubleRoad
    final Button b6 = (Button) namespace.get("butt6"); // get element by fx:id  //insert DoubleRoad ROTATE LEFT
    final Button b7 = (Button) namespace.get("butt7"); // get element by fx:id  //insert DoubleRoad ROTATE RIGHT

    final Button b8 = (Button) namespace.get("butt8"); // get element by fx:id  //insert SingleRoad
    final Button b9 = (Button) namespace.get("butt9"); // get element by fx:id  //insert SingleRoad ROTATE LEFT
    final Button b10 = (Button) namespace.get("butt10"); // get element by fx:id  //insert SingleRoad ROTATE RIGHT

    final CheckBox c1 = (CheckBox) namespace.get("check1");


    c1.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        try {
          if (c1.isSelected()) {
            Check = true;
          } else {
            Check = false;
          }
        }
        catch(Exception e) {
        }
      }
    }
    );
    //CORNERPIECE BUTTON
    b1.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        tools = 1;
        rot1 = 1;
        displayCursorImage();
      }
    }
    );
    b2.setOnAction(new EventHandler<ActionEvent>() { //ROTATE LEFT
      @Override
        public void handle(ActionEvent event) {
        rot1 -= 1;
        if (rot1<1) {
          rot1 = 4;
        }
        displayCursorImage();
      }
    }
    );
    b3.setOnAction(new EventHandler<ActionEvent>() { //ROTATE RIGHT
      @Override
        public void handle(ActionEvent event) {
        rot1 += 1;
        if (rot1>4) {
          rot1 = 1;
        }
        displayCursorImage();
      }
    }
    );
    //INSERT CARS BUTTON
    b4.setOnAction(new EventHandler<ActionEvent>() {
      @Override
        public void handle(ActionEvent event) {
        cursor(ARROW);
        tools = 2;
      }
    }
    );
    //DOUBLEROAD BUTTON
    b5.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        tools = 3;
        rot2 = 1;
        displayCursorImage();
      }
    }
    );
    b6.setOnAction(new EventHandler<ActionEvent>() { //ROTATE LEFT
      @Override
        public void handle(ActionEvent event) {
        rot2 -= 1;
        if (rot2<1) {
          rot2 = 4;
        }
        displayCursorImage();
      }
    }
    );    
    b7.setOnAction(new EventHandler<ActionEvent>() { //ROTATE RIGHT
      @Override
        public void handle(ActionEvent event) {
        rot2 += 1;
        if (rot2>4) {
          rot2 = 1;
        }
        displayCursorImage();
      }
    }
    );
    //SINGLEROAD BUTTON
    b8.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        tools = 4;
        rot3 = 1;
        displayCursorImage();
      }
    }
    );
    b9.setOnAction(new EventHandler<ActionEvent>() { //ROTATE LEFT
      @Override
        public void handle(ActionEvent event) {
        rot3 -= 1;
        if (rot3<1) {
          rot3 = 8;
        }
        displayCursorImage();
      }
    }
    );    
    b10.setOnAction(new EventHandler<ActionEvent>() { //ROTATE RIGHT
      @Override
        public void handle(ActionEvent event) {
        rot3 += 1;
        if (rot3>8) {
          rot3 = 1;
        }
        displayCursorImage();
      }
    }
    );

    final AnchorPane pane = (AnchorPane) namespace.get("anchorPane"); // get element by fx:id  
    System.out.println(namespace.get("anchorPane"));
    pane.getChildren().add(canvas); // processing to stackPane


    canvas.widthProperty().bind(pane.widthProperty()); // bind canvas dimensions to pane
    canvas.heightProperty().bind(pane.heightProperty()); // bind canvas dimensions to pane

    Platform.runLater(new Runnable() {

      @Override
        public void run() {
        stage.setScene(newScene);
      }
    }
    );
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  return surface;
}

void setup() {
  size(800, 800, FX2D); // FX2D bruger funktionen  initSurface()
  frameRate(30);

  rows = round(width/Scale);
  columns = round(height/Scale);

  vejFelt = new Road[rows][columns];

  car = new ArrayList<cars>();

  for (int r = 0; r < rows; r++) {
    for (int R = 0; R < columns; R++) {
      vejFelt[r][R] = new Road(r, R, 1, false);
    }
  }
}

void draw() {
  background(50,205,50);
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
  text(frameRate, 20, 20);
  text("KøScore: " + queueCounter + " (Lavere = bedre)", 20, 40);

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
  stroke(34,139,34);
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
  if (tools == 1) {
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
  } else if (tools == 2) {
  }
}

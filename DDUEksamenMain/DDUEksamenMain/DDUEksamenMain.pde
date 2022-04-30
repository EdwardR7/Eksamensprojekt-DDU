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

int Scale = 20; // size of each cell
int rows; // rows of board
int columns; // colums of board

Road[][] vejFelt; //Vejfelter
boolean[][] collision; //Collisiondetection
boolean[] pressed = new boolean[256];

int x, y;
ArrayList<cars> car;

int rotate = 0;
int tools = 0;

PImage rImage;



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


    final Button b1 = (Button) namespace.get("butt1"); // get element by fx:id  
    final Button b2 = (Button) namespace.get("butt2"); // get element by fx:id  
    final Button b3 = (Button) namespace.get("butt3"); // get element by fx:id  
    final Button b4 = (Button) namespace.get("butt4"); // get element by fx:id  


    //System.out.println(namespace.get("butt1"));


    b1.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        tools = 1;
        rotate = 1;
        rImage = loadImage("UpRight.PNG");
        cursor(rImage);
        System.out.println("Corner insert"); //Skriv funktioner her
        frameRate(30);
      }
    }
    );

    b2.setOnAction(new EventHandler<ActionEvent>() {
      @Override
        public void handle(ActionEvent event) {


        rotate -= 1;
        if (rotate<1) {
          rotate = 4;
        }
        System.out.println(rotate);
        //rotate left

        if (tools == 1) {
          switch(rotate) {
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
          cursor(rImage);
        }
      }
    }
    );

    b3.setOnAction(new EventHandler<ActionEvent>() {
      @Override
        public void handle(ActionEvent event) {



        rotate += 1;
        if (rotate>4) {
          rotate = 1;
        }


        System.out.println(rotate);
        //rotate right
        if (tools == 1) {
          switch(rotate) {
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
          cursor(rImage);
        }
      }
    }
    );

    b4.setOnAction(new EventHandler<ActionEvent>() {
      @Override
        public void handle(ActionEvent event) {
        cursor(ARROW);
        tools = 2;
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
  size(1400, 1400, FX2D);



  rows = round(width/Scale);
  columns = round(height/Scale);

  vejFelt = new Road[rows][columns];
  collision = new boolean[rows][columns];

  car = new ArrayList<cars>();

  for (int i = 0; i < 10; i++) {
    car.add(new cars(round(random(0, rows)), round(random(0, columns))));
  }
  for (int r = 0; r < rows; r++) {
    for (int R = 0; R < columns; R++) {
      vejFelt[r][R] = new Road(r, R, 1, false);
    }
  }
}


void draw() {



  background(-1);
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
}

void drawGrid() {
  stroke(230);
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
  case 2:
    try {
      car.add(new cars(round(mouseX)/Scale, round(mouseY)/Scale));
    }
    catch( Exception e) {
    }
    break;
  }
}

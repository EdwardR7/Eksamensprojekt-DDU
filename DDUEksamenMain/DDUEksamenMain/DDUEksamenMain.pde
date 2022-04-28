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

int Scale = 8; // size of each cell
int rows; // rows of board
int columns; // colums of board

Road[][] vejFelt; //Vejfelter
boolean[][] collision; //Collisiondetection


int x, y;
ArrayList<cars> car;


protected PSurface initSurface() {
  surface = (PSurfaceFX) super.initSurface();
  final Canvas canvas = (Canvas) surface.getNative();
  final Scene oldScene = canvas.getScene();
  final Stage stage = (Stage) oldScene.getWindow();
  
  try {
    FXMLLoader loader = new FXMLLoader(Paths.get(System.getProperty("user.home"), "Documents", "GitHub", "Eksamensprojekt-DDU", "DDUEksamenMain", "DDUEksamenMain", "Scene.fxml").toUri().toURL()); // abs path to fxml file
    final Parent sceneFromFXML = loader.load();
    final Map<String, Object> namespace = loader.getNamespace();
    final Scene newScene = new Scene(sceneFromFXML, stage.getWidth(), stage.getHeight(), false, SceneAntialiasing.BALANCED);
    

    final Button b1 = (Button) namespace.get("butt1"); // get element by fx:id  
    final Button b2 = (Button) namespace.get("butt2"); // get element by fx:id  
    
    System.out.println(namespace.get("butt1"));
    b1.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
    public void handle(ActionEvent event) {
          
    System.out.println("KNAP 1"); //Skriv funktioner her
    frameRate(30);
    }
});

    b2.setOnAction(new EventHandler<ActionEvent>() {
    @Override
    public void handle(ActionEvent event) {
      
    System.out.println("KNAP 2");
    frameRate(120);
    }
});

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
  size(800, 800,FX2D);

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


void mouseDragged() {
  try {
    vejFelt[round(mouseX/Scale)][round(mouseY/Scale)] = new Road(round(mouseX/Scale), round(mouseY/Scale), 1, true);
    vejFelt[round(mouseX/Scale)][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale), round(mouseY/Scale)+1, 1, true);
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale), 1, true);
    vejFelt[round(mouseX/Scale)+1][round(mouseY/Scale)+1] = new Road(round(mouseX/Scale)+1, round(mouseY/Scale)+1, 1, true);
  } 
  catch( Exception e) {
  }
}

void mouseClicked() {
  try {
    car.add(new cars(round(mouseX)/Scale, round(mouseY)/Scale));
  }
  catch( Exception e) {
  }
}

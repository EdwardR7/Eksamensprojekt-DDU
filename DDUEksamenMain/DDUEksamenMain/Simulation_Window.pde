Scene simulationController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Scene.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, 1000, 720, false, SceneAntialiasing.BALANCED);

  final Button b1 = (Button) namespace.get("butt1"); // get element by fx:id  //insert corners
  final Button b111 = (Button) namespace.get("butt111"); // get element by fx:id  //LYSKRYDS
  final Button b420 = (Button) namespace.get("butt420"); // get element by fx:id  //Start simulation
  final Button b4 = (Button) namespace.get("butt4"); // get element by fx:id //insert cars
  final Button b69 = (Button) namespace.get("butt69"); // get element by fx:id //SLET KNAP

  final Button b5 = (Button) namespace.get("butt5"); // get element by fx:id  //insert DoubleRoad
  final Button b6 = (Button) namespace.get("butt6"); // get element by fx:id  //insert DoubleRoad ROTATE LEFT
  final Button b7 = (Button) namespace.get("butt7"); // get element by fx:id  //insert DoubleRoad ROTATE RIGHT

  final Button b8 = (Button) namespace.get("butt8"); // get element by fx:id  //insert SingleRoad
  final Button b11 = (Button) namespace.get("butt11"); // get element by fx:id  //insert SingleRoad ROTATE RIGHT
  final Button b12 = (Button) namespace.get("butt12"); // get element by fx:id  //insert SingleRoad ROTATE RIGHT

  final Label savedMapMessage = (Label) namespace.get("savedMessage"); // get element by fx:id  //insert corners
  final CheckBox c1 = (CheckBox) namespace.get("check1");
  final TextField mapName = (TextField) namespace.get("MapName"); // get element by fx:id  //insert corners


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
      displayCursorImage();
    }
  }
  );
  //CORNERPIECE BUTTON
  b1.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      tools = 1;
      rot = 1;
      displayCursorImage();
    }
  }
  );
  //SLETKNAP BUTTON
  b69.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      tools = 6;
      displayCursorImage();
    }
  }
  );

  //LYSKRYDS BUTTON
  b111.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      tools = 5;
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
      displayCursorImage();
    }
  }
  );
  //DOUBLEROAD BUTTON
  b5.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      tools = 3;
      rot = 1;
      displayCursorImage();
    }
  }
  );
  b6.setOnAction(new EventHandler<ActionEvent>() { //ROTATE LEFT
    @Override
      public void handle(ActionEvent event) {
      rotateLeft();
      displayCursorImage();
    }
  }
  );    
  b7.setOnAction(new EventHandler<ActionEvent>() { //ROTATE RIGHT
    @Override
      public void handle(ActionEvent event) {
      rotateRight();
      displayCursorImage();
    }
  }
  );
  //SINGLEROAD BUTTON
  b8.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      tools = 4;
      rot = 1;
      displayCursorImage();
    }
  }
  );
  //SIMULATION BUTTON
  b420.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      displayCursorImage();
      car.clear();
      for (int r = 0; r < rows; r++) {
        for (int R = 0; R < columns; R++) {
          vejFelt[r][R].collision = false;
        }
      }
      for (int r = 0; r < rows; r++) {
        for (int R = 0; R < columns; R++) {
          if (vejFelt[r][R].roadtile && vejFelt[r][R].retning != 0 && !vejFelt[r][R].collision) {
            if (random(1) < 0.3333) {
              car.add(new cars(r, R));
            }
          }
        }
      }
      simstart = true;
      simtimer = 0;
      score = 0;
    }
  }
  );

  b11.setOnAction(new EventHandler<ActionEvent>() { //SAVE MAP
    @Override
      public void handle(ActionEvent event) {
      displayCursorImage();
      DB.saveMap(mapName.getText());


      message = "Your map has been saved!";
      savedMapMessage.setText(message);
    }
  }
  );

  b12.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        mapContents.clear();
        stage.setScene(menuController(stage, canvas));
      }
      catch(Exception e) {
        println(e);
      }
    }
  }
  );

  final AnchorPane pane = (AnchorPane) namespace.get("anchorPane"); // get element by fx:id  
  pane.getChildren().add(canvas); // processing to stackPane

  canvas.widthProperty().bind(pane.widthProperty()); // bind canvas dimensions to pane
  canvas.heightProperty().bind(pane.heightProperty()); // bind canvas dimensions to pane

  return newScene;
}

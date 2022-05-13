Scene simulationController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Scene.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, 1000, 720, false, SceneAntialiasing.BALANCED);

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
          tools = 5;
        } else {
          Check = false;
          tools = 0;
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
  b11.setOnAction(new EventHandler<ActionEvent>() { //SAVE MAP
    @Override
      public void handle(ActionEvent event) {
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

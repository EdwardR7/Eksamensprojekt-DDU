Scene menuController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Menu.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, stage.getWidth(), stage.getHeight(), false, SceneAntialiasing.BALANCED);

  final Button StartSim = (Button) namespace.get("StartSimulation"); // get element by fx:id  //insert corners
  final Button Exit = (Button) namespace.get("Exit"); // get element by fx:id  //insert corners
  final Button Tilbage = (Button) namespace.get("Tilbage"); // get element by fx:id  //insert corners
  final Button loadSelectedMap = (Button) namespace.get("loadSelected"); // get element by fx:id  //insert corners


  final Label loggedName = (Label) namespace.get("logName"); // get element by fx:id  //insert corners
  final ListView mapList = (ListView) namespace.get("mapView"); // get element by fx:id  //insert corners
  DB.setMapList();
  for (String map : mapContents) {
    mapList.getItems().add(map);
  }

  try {
    loggedName.setText(logName);
  }
  catch(Exception e) {
  }

  StartSim.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        stage.setScene(simulationController(stage, canvas));
      }
      catch(Exception e) {
        println(e);
      }
    }
  }
  );

  Exit.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        exit();
      }
      catch(Exception e) {
      }
    }
  }
  );

  Tilbage.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        stage.setScene(loginController(stage, canvas));
      }
      catch(Exception e) {
      }
    }
  }
  );

  mapList.setOnMouseClicked(new EventHandler<MouseEvent>() {
    @Override
      public void handle(MouseEvent arg0) {
      //Check wich list index is selected then set txtContent value for that index 

      savedMap = mapList.getSelectionModel().getSelectedItem().toString();
      System.out.println(savedMap);
    }
  }
  );


  loadSelectedMap.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        stage.setScene(simulationController(stage, canvas));
        DB.loadMap();
      }
      catch(Exception e) {
      }
    }
  }
  );




  return newScene;
}

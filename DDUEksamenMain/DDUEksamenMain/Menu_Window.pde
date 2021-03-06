Scene menuController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Menu.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, 1000, 720, false, SceneAntialiasing.BALANCED);

  final Button ClearScene = (Button) namespace.get("StartSimulation"); // get element by fx:id  //insert corners
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

  ClearScene.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        car.clear();
        mapContents.clear();
        stage.setScene(simulationController(stage, canvas));
        DB.ClearMethod();
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
        Logged = false;
        userID = 0;
        logName = null;
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
      try {
        savedMap = mapList.getSelectionModel().getSelectedItem().toString();
        System.out.println(savedMap);
      }

      catch(Exception e) {
      }
    }
  }
  );


  loadSelectedMap.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        car.clear();
        DB.ClearMethod();
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

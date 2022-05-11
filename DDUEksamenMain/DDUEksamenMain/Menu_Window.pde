Scene menuController(final Stage stage, final Canvas canvas) throws IOException {
    FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Menu.fxml").toUri().toURL()); // abs path to fxml file

    final Parent sceneFromFXML = loader.load();
    final Map<String, Object> namespace = loader.getNamespace();
    final Scene newScene = new Scene(sceneFromFXML, stage.getWidth(), stage.getHeight(), false, SceneAntialiasing.BALANCED);

    final Button StartSim = (Button) namespace.get("StartSimulation"); // get element by fx:id  //insert corners
    final Button Exit = (Button) namespace.get("Exit"); // get element by fx:id  //insert corners
    final Button regAcc = (Button) namespace.get("regAcc"); // get element by fx:id  //insert corners

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
    
    regAcc.setOnAction(new EventHandler<ActionEvent>() { 
      @Override
        public void handle(ActionEvent event) {
        try {
         stage.setScene(registerController(stage, canvas));
        }
        catch(Exception e) {
          println(e);
        }
      }
    }
    );

    return newScene;
}

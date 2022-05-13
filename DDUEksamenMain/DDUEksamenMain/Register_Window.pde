Scene registerController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Register.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, stage.getWidth(), stage.getHeight(), false, SceneAntialiasing.BALANCED);

  final Button register = (Button) namespace.get("register"); // get element by fx:id  //insert corners
  final Button goBack = (Button) namespace.get("back"); // get element by fx:id  //insert corners

  final TextField regUsername= (TextField) namespace.get("regUser"); // get element by fx:id  //insert corners
  final TextField regPassword = (TextField) namespace.get("regPass1"); // get element by fx:id  //insert corners
  final TextField regPasswordConfirm = (TextField) namespace.get("regPass2"); // get element by fx:id  //insert corners
  final Label confMessage = (Label) namespace.get("Message"); // get element by fx:id  //insert corners


  register.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {

        //if(regPassword.getText() == regPasswordConfirm.getText()){ 
        println(regPassword.getText());
        println(regPasswordConfirm.getText());

        if (regUsername.getText().length() < 1  && regPassword.getText().length() < 1 && regPasswordConfirm.getText().length() < 1) {
          message = "Intet brugernavn eller kodeord indskrevet";
        } else {

          DB.RegisterAccount(regUsername.getText(), regPassword.getText(), regPasswordConfirm.getText());
          
        }

        confMessage.setText(message);

      }
      catch(Exception e) {
        println(e);
      }
    }
  }
  );



  goBack.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        stage.setScene(loginController(stage, canvas));
      }
      catch(Exception e) {
        println(e);
      }
    }
  }
  );

  return newScene;
}

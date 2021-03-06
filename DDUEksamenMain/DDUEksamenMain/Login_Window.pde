Scene loginController(final Stage stage, final Canvas canvas) throws IOException {
  FXMLLoader loader = new FXMLLoader(Paths.get(sketchPath(), "FXML", "Login.fxml").toUri().toURL()); // abs path to fxml file

  final Parent sceneFromFXML = loader.load();
  final Map<String, Object> namespace = loader.getNamespace();
  final Scene newScene = new Scene(sceneFromFXML, 1000, 720, false, SceneAntialiasing.BALANCED);


  final Button Exit = (Button) namespace.get("Exit"); // get element by fx:id  //insert corners
  final Button regAcc = (Button) namespace.get("regAcc"); // get element by fx:id  //insert corners
  final Button Login = (Button) namespace.get("Login"); // get element by fx:id  //insert corners


  final TextField Username = (TextField) namespace.get("Username"); // get element by fx:id  //insert corners
  final TextField Password = (TextField) namespace.get("Password"); // get element by fx:id  //insert corners

  final Label confMessage = (Label) namespace.get("Message"); // get element by fx:id  //
  final Label loggedName = (Label) namespace.get("logName"); // get element by fx:id  //

  try {
    loggedName.setText(logName);
  }
  catch(Exception e) {
  }

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

  Login.setOnAction(new EventHandler<ActionEvent>() { 
    @Override
      public void handle(ActionEvent event) {
      try {
        if (Username.getText().length() < 1  && Password.getText().length() < 1) {
          message = "Intet brugernavn eller kodeord indskrevet";
        } else {


          DB.LogVerify(Username.getText(), Password.getText());

          if (Logged == true) {
            mapContents.clear();
            stage.setScene(menuController(stage, canvas));
          }
        }

        confMessage.setText(message);
        loggedName.setText(logName);
      }
      catch(Exception e) {
        println(e);
      }
    }
  }
  );    


  return newScene;
}

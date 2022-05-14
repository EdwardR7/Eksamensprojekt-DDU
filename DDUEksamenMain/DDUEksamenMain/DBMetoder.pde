
class DBMetoder {

  void LogVerify(String User, String Pass) {
    if (db.connect()) {
      db.query("SELECT ID_User FROM Users WHERE Username='" + User + "' AND Password='" + hashKode(Pass) + "'");
      if (db.next()) {
        println("Working login");
        println(db.getInt("ID_User")); //User identifcation, which user is currently logged in
        userID = db.getInt("ID_User");

        message = "Log ind success";
        Logged = true;
      } else {
        message = "Brugernavn eller password er forkert";
      }
    }
    LogName();
  }

  void RegisterAccount(String User, String Pass1, String Pass2) {

    if (db.connect()) {
      db.query("SELECT Username FROM Users WHERE Username='" + User + "'");
      if (db.next()) {
        message = "Brugernavn findes allerede";
      } else {

        if (User.length() >= 1  && Pass1.length() >= 1 && Pass2.length() >= 1 && Pass1.equals(Pass2)) {            
          if (db.connect()) {
            db.query("INSERT INTO Users(Username, Password) VALUES ('" + User + "', '" + hashKode(Pass1) + "'); ");
            message = "Brugeren blev registreret";
          }
        } else {
          message = "Kodeordene stemmer ikke overens";
        }
      }
    }
  }

  void LogName() { //Sets current logged in user
    if (db.connect()) {
      db.query("SELECT Username FROM Users WHERE ID_User='" + userID + "'");
      if (db.next()) {
        println("Working login");
        println(db.getString("Username")); //User identifcation, which user is currently logged in
        logName = db.getString("Username");
      } else {
        message = "Brugernavn eller password er forkert";
      }
    }
  }

  void saveMap(String MapName) { //Inserts map data into most recently created map ID 
    int mapID;
    if (db.connect()) {
      db.query("INSERT INTO Maps(Name, User_ID) VALUES ('" + MapName + "', '" + userID + "'); ");
    }

    if (db.connect()) {
      db.query("SELECT Maps.ID_Map FROM Maps WHERE Maps.User_ID='" + userID + "' AND Maps.Name='" + MapName + "' ");
      if (db.next()) {
        println("Testt");
        println(db.getInt("ID_Map")); //User identifcation, which user is currently logged in
        mapID = db.getInt("ID_Map");
        try {
          for (int r = 0; r < rows; r++) {
            for (int R = 0; R < columns; R++) {
              if (vejFelt[r][R].roadtile) {
                int lyskryds = 0;
                if (vejFelt[r][R].lyskryds) {
                  lyskryds = 1;
                } else {
                  lyskryds = 0;
                }

                db.query("INSERT INTO MapDATA(Map_ID, x, y, retning, lyskryds, timer) VALUES ('" + mapID + "', '" + round(vejFelt[r][R].x)/Scale + "', '" + round(vejFelt[r][R].y)/Scale + "', '" + vejFelt[r][R].retning + "', '" + lyskryds + "', '" + vejFelt[r][R].timer + "'); ");
              }
            }
          }
        }

        catch(Exception e) {
        }
      }
    }
  }

  void loadMap() {

    if (db.connect()) {
      db.query("SELECT MapDATA.x, MapDATA.y, MapDATA.retning, MapDATA.lyskryds, MapDATA.timer FROM ((Users INNER JOIN Maps ON Maps.User_ID = Users.ID_User) INNER JOIN MapDATA ON Maps.ID_Map = MapDATA.Map_ID) WHERE Maps.User_ID='" + userID + "' AND Maps.Name='" + savedMap + "'");
      while (db.next()) {
        boolean lyskryds = false;
        if (db.getInt("lyskryds") == 1) {
          lyskryds = true;
        } else {
          lyskryds = false;
        }

        vejFelt[db.getInt("x")][db.getInt("y")] = new Road(db.getInt("x"), db.getInt("y"), db.getInt("retning"), true, lyskryds, db.getInt("timer"));
      }
    }
  }
  void setMapList() {
    if (db.connect()) {
      db.query("SELECT ID_Map, Name FROM (Users INNER JOIN Maps ON Maps.User_ID = Users.ID_User) WHERE Maps.User_ID='" + userID + "'");
      while (db.next()) {
        mapContents.add(db.getString("Name"));
      }
    }
  }

  void ClearMethod() {
    for (int r = 0; r < rows; r++) {
      for (int R = 0; R < columns; R++) {
        vejFelt[r][R] = new Road(r, R, 9, false, false, 0);
      }
    }
  }
  
  String hashKode(String inputTekst){
    try {
    //Vha. MessageDigest kan vi anvende en hashing algoritme.... her SHA-256 ...
    //prøv f.eks. MD5 og se om du kan bryde den ved at søge på nettet!
    MessageDigest md = MessageDigest.getInstance("SHA-256"); 

    //MassageDigest objektet "fodres" med teksten, der skal "hashes"
    md.update(inputTekst.getBytes());    

    //digest funktionen giver "hash-værdien", men i hexadecimale bytes 
    byte[] byteList = md.digest();

    //Her anvendes processings hex funktion, der kan konvertere hexadecimale bytes til Strings
    //så det er muligt at læse "hash-værdien"
    StringBuffer hashedValueBuffer = new StringBuffer();
    for (byte b : byteList)hashedValueBuffer.append(hex(b)); 
    return hashedValueBuffer.toString();
  }

  catch (Exception e) {
    System.out.println("Exception: "+e);
    return "";
  }
  }
  
}

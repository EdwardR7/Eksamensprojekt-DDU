import de.bezier.data.sql.*;


class DBMetoder {


  void LogVerify(String User, String Pass) {
    if (db.connect()) {
      db.query("SELECT ID_User FROM Users WHERE Username='" + User + "' AND Password='" + Pass + "'");
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
            db.query("INSERT INTO Users(Username, Password) VALUES ('" + User + "', '" + Pass1 + "'); ");
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
                db.query("INSERT INTO MapDATA(Map_ID, x, y, retning) VALUES ('" + mapID + "', '" + round(vejFelt[r][R].x)/Scale + "', '" + round(vejFelt[r][R].y)/Scale + "', '" + vejFelt[r][R].retning + "'); ");
                println(round(vejFelt[r][R].x));
                println(round(vejFelt[r][R].y));
                println(vejFelt[r][R].retning);
              }
            }
          }
        }

        catch(Exception e) {
        }

        //   ResultSet rs = stat.executeQuery("INSERT INTO Maps(Name) VALUES ('" + "test" + "') WHERE (Users INNER JOIN Maps ON Maps.ID_User = User.id) AND WHERE User.Name='" + CurrentUser + "'");    
        //   ResultSet rs = stat.executeQuery("SELECT Elev.NAVN, Elev.ID FROM (((Lærer INNER JOIN Quiz ON Quiz.Lærer_ID = Lærer.ID) INNER JOIN ELEV_SVAR ON Quiz.ID=Elev_Svar.ID_Quiz) INNER JOIN Elev ON Elev_Svar.ID_Elev = Elev.ID) Where Lærer.ID = '" + CurrentUser + "'");

        //}
      }
    }
  }

  void loadMap() {

    if (db.connect()) {
      db.query("SELECT MapDATA.x, MapDATA.y, MapDATA.retning FROM ((Users INNER JOIN Maps ON Maps.User_ID = Users.ID_User) INNER JOIN MapDATA ON Maps.ID_Map = MapDATA.Map_ID) WHERE Maps.User_ID='" + userID + "' AND Maps.Name='" + savedMap + "'");
      while (db.next()) {
        vejFelt[db.getInt("x")][db.getInt("y")] = new Road(db.getInt("x"), db.getInt("y"), db.getInt("retning"), true);
        // println(db.getInt("ID_Map")); //User identifcation, which user is currently logged in
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
        vejFelt[r][R] = new Road(r, R, 0, false);
      }
    }
  }
}

import de.bezier.data.sql.*;


class DBMetoder {


  void LogVerify(String User, String Pass) {
    if (db.connect()) {
      db.query("SELECT ID FROM Users WHERE Username='" + User + "' AND Password='" + Pass + "'");
      if (db.next()) {
        println("Working login");
        println(db.getInt("ID")); //User identifcation, which user is currently logged in
        userID = db.getInt("ID");


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
}
void LogName() { //Sets current logged in user
  if (db.connect()) {
    db.query("SELECT Username FROM Users WHERE ID='" + userID + "'");
    if (db.next()) {
      println("Working login");
      println(db.getString("Username")); //User identifcation, which user is currently logged in
      logName = db.getString("Username");
    } else {
      message = "Brugernavn eller password er forkert";
    }
  }
}

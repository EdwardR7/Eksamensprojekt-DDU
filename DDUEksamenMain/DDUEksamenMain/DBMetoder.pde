import de.bezier.data.sql.*;


class DBMetoder{
  void Register(String User, String Pass){
    if(db.connect()){
      db.query("INSERT INTO Users(Username, Password) VALUES ('" + User + "', '" + Pass + "'); ");
    }
    
  }
  
}

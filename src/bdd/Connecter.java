package bdd;




import java.sql.*;

public class Connecter{
//CTRL + SHIFT + O pour générer les imports
public static void main(String args[]) {

}
    Connection con;
  public Connecter() {
     
    try {
        Class.forName("org.postgresql.Driver");
    }
    catch(ClassNotFoundException e)
    {
        System.err.println(e);
    }
      
    try{
        con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/aeroclub","postgres","postgres");
      }
    catch(SQLException e){
        System.err.println(e);
      }
  }
     public Connection obtenirconnexion()
             {
                 return con;
             }
    } 
    


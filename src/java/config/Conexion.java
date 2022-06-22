
package config;


import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;
import javax.swing.JOptionPane;
/**
 *
 * @author Gustavo
 */
public class Conexion {
    public static final String URL = "jdbc:mysql://localhost/clinicabiomed";
    public static final String USERNAME = "root";
    public static final String PASWORD = "";
    //PreparedStatement ps;
    ResultSet rs;

    
    //Método para la conectividad - constructor
    public static Connection getConection() {
        Connection con = null;
        try {
            //obtenemos el Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USERNAME, PASWORD);

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return con;
    }
    
    public Conexion() {
    }
    

    
   

    
}

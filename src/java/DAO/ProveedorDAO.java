
package DAO;


import config.Conexion;
import Entidades.Proveedor;
import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Gustavo
 */
public class ProveedorDAO {
    
    
      public Vector<Proveedor> listarProveedores(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         Vector<Proveedor> list=new Vector<Proveedor>();
           Proveedor cr=null;
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarproveedor()} ");
                     
            rs = cstm.executeQuery();
             
            
           cr = new Proveedor();
            cr.setId_persona(0);
            cr.setNom_persona("seleccione un Proveedor");
            list.add(cr);
   
            while(rs.next()){
             cr = new Proveedor();
            cr.setId_persona(rs.getInt("Id_persona"));
            cr.setNom_persona(rs.getString("Nom_persona"));
            list.add(cr);
   
            }
            return list;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }finally{
            try {
               if(rs!=null) rs.close();
               if(cstm!=null) cstm.close();
               
               
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }  
        }    
        return list;
    }  
    
    
    
    
    
    
    
}


package DAO;

import config.Conexion;
import Entidades.Cargo;
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
public class CargoDAO {
    
    
      public Vector<Cargo> listarCargos(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         Vector<Cargo> list=new Vector<Cargo>();
           Cargo cr=null;
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarcargo()} ");
                     
            rs = cstm.executeQuery();
             
            
           cr = new Cargo();
            cr.setId_cargo(0);
            cr.setDes_cargo("Seleccione un Cargo");
            list.add(cr);
   
            while(rs.next()){
             cr = new Cargo();
            cr.setId_cargo(rs.getInt("Id_cargo"));
            cr.setDes_cargo(rs.getString("des_cargo"));
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

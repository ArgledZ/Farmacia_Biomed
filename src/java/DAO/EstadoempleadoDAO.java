
package DAO;


import config.Conexion;
import Entidades.Estadoempleado;
import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import java.util.Vector;

/**
 *
 * @author Gustavo
 */
public class EstadoempleadoDAO {
    
    
      public Vector<Estadoempleado> listarEstados(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         Vector<Estadoempleado> list=new Vector<Estadoempleado>();
           Estadoempleado cr=null;
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarestadoempleado()} ");
                     
            rs = cstm.executeQuery();
             
            
           cr = new Estadoempleado();
            cr.setId_estadoempleado(0);
            cr.setDes_estadoempleado("Seleccione un Estado");
            list.add(cr);
   
            while(rs.next()){
             cr = new Estadoempleado();
            cr.setId_estadoempleado(rs.getInt("Id_estadoempleado"));
            cr.setDes_estadoempleado(rs.getString("des_estadoempleado"));
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

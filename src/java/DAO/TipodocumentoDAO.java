
package DAO;

import config.Conexion;
import Entidades.Cargo;
import Entidades.Tipodocumento;
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
public class TipodocumentoDAO {
    
    
      public Vector<Tipodocumento> listardocumentos(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         Vector<Tipodocumento> list=new Vector<Tipodocumento>();
           Tipodocumento cr=null;
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistartipodocumento()} ");
                     
            rs = cstm.executeQuery();
             
            
           cr = new Tipodocumento();
            cr.setId_tipo_documento(0);
            cr.setDes_tipo_documento("Seleccione Tipo Documento");
            list.add(cr);
   
            while(rs.next()){
             cr = new Tipodocumento();
          
            cr.setId_tipo_documento(rs.getInt("Id_tipo_documento"));
            cr.setDes_tipo_documento(rs.getString("Des_tipo_documento"));
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

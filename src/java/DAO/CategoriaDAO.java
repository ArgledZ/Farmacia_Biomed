
package DAO;


import config.Conexion;
import Entidades.Categoria;
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
public class CategoriaDAO {
    
    
      public Vector<Categoria> listarCategorias(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         Vector<Categoria> list=new Vector<Categoria>();
           Categoria cr=null;
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarcategoria()} ");
                     
            rs = cstm.executeQuery();
             
            
           cr = new Categoria();
            cr.setId_categoria(0);
            cr.setDes_categoria("seleccione una Categoria");
            list.add(cr);
   
            while(rs.next()){
             cr = new Categoria();
            cr.setId_categoria(rs.getInt("Id_Categoria"));
            cr.setDes_categoria(rs.getString("des_categoria"));
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

package DAO;

import config.Conexion;
import Entidades.Categoria;
import Entidades.Producto;


import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    
        public List<Producto> listarProductos(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         List<Producto> list=null;
          
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarproducto()} ");
             
            list=new ArrayList<>();
            Producto em=null;
            rs = cstm.executeQuery();
            
            while(rs.next()){
                em =new Producto();
                em.setId_producto(parseInt(rs.getString("Id_producto")));
                //em.setCategoria(new Categoria(rs.getInt("Id_categoria"),""));
                em.getCategoria().setDes_categoria(rs.getString("Des_categoria"));
               // em.setCategoria(new Categoria(rs.getInt("Id_categoria"),rs.getString("Des_categoria")));
                em.setReg_sanitario(rs.getString("Reg_sanitario"));
                em.setNombre_producto(rs.getString("Nombre_producto"));
                em.setPrecio_compra(rs.getString("Precio_compra"));
                em.setPrecio_venta(rs.getString("Precio_venta"));
                em.setConcentracion_producto(rs.getString("Concentracion_producto"));
                
               
                
                list.add(em);
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
        
    //INSERTAR
        
          public boolean insertar(Producto produ){
        
       boolean confirmacion2=false;
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
     
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL painsertarproducto(?,?,?,?,?,?)}");
           cstm.setInt(1, produ.getCategoria().getId_categoria());
           cstm.setString(2, produ.getReg_sanitario());
           cstm.setString(3,produ.getNombre_producto());
           cstm.setString(4,produ.getPrecio_compra());
           cstm.setString(5,produ.getPrecio_venta());
           cstm.setString(6,produ.getConcentracion_producto());
          
          
          
           
           confirmacion2 = cstm.execute();
            
          
            
        } catch (Exception ex) {
            
            System.out.println(ex.getMessage());
            
        }finally{
         
             try {
                 
                  if(cstm!=null) cstm.close();
                  
                                 
             } catch (Exception e) {
                 System.out.println(e.getMessage());
                 
             }
            
         
         }
        return true;
   
    }     
        
        
        
        
  //BUSCAREMPLEADO
        
       public List<Producto> buscarProducto(String producto){
        List<Producto> list=null;
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
        try {
            //con=Conexion.getConexion();
            //String sql="select * from cliente where Apellidos like '"+cliente+"%'";
            
            //pstm=con.prepareStatement(sql);
            //rs=pstm.executeQuery();
            
            //list=new ArrayList<>();
            //Cliente client=null;
           
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call pabuscarproducto(?)} ");
           cstm.setString(1, producto);
           rs = cstm.executeQuery(); 
           
            list=new ArrayList<>();
            Producto em=null;
           
            
            
            while(rs.next()){
                 em =new Producto();
                em.setId_producto(parseInt(rs.getString("Id_producto")));
                em.setCategoria(new Categoria(rs.getInt("Id_categoria"),""));
                em.setCategoria(new Categoria(rs.getInt("Id_categoria"),rs.getString("Des_categoria")));
                em.setReg_sanitario(rs.getString("Reg_sanitario"));
                em.setNombre_producto(rs.getString("Nombre_producto"));
                em.setPrecio_compra(rs.getString("Precio_compra"));
                em.setPrecio_venta(rs.getString("Precio_venta"));
                em.setConcentracion_producto(rs.getString("Concentracion_producto"));
                
                list.add(em);
            }
         
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }finally{
            try {
               if(rs!=null) rs.close();
               if(cstm!=null) cstm.close();
               if(con!=null) con.close();
               
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }  
        }    
        return list;
    } 
        
       
       
    //MODIFICAR EMPLEADO
       
         public boolean actualiza(Producto produ){
        
      
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
          
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL pamodificarproducto(?,?,?,?,?,?,?)}");
           cstm.setInt(1, produ.getId_producto());
           cstm.setInt(2, produ.getCategoria().getId_categoria());
           cstm.setString(3, produ.getReg_sanitario());
           cstm.setString(4,produ.getNombre_producto());
           cstm.setString(5,produ.getPrecio_compra());
           cstm.setString(6,produ.getPrecio_venta());
           cstm.setString(7,produ.getConcentracion_producto());
           
           cstm.executeUpdate();
            
          
            
               
        } catch (Exception ex) {
            
            System.out.println(ex.getMessage());
            
        }finally{
         
             try {
                 
                  if(cstm!=null) cstm.close();
                  
                                 
             } catch (Exception e) {
                 System.out.println(e.getMessage());
                 
             }
            
         
         }
        return true;
   
    }    
       
       
   //ELIMINAR EMPLEADO
       
     public boolean Eliminar(Producto producto){
        
       boolean confirmacion=false;
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
          
          
            con=Conexion.getConection();
           cstm = con.prepareCall("{ call paeliminarproducto(?,?)} ");
           cstm.setInt(1, producto.getId_producto());
           cstm.setInt(2, 1);
           confirmacion = cstm.execute();
            
          
            
        } catch (Exception ex) {
            
            System.out.println(ex.getMessage());
            
        }finally{
         
             try {
                 
                  if(cstm!=null) cstm.close();
                  
                                 
             } catch (Exception e) {
                 System.out.println(e.getMessage());
                 
             }
            
         
         }
        return true;
   
    } 

}

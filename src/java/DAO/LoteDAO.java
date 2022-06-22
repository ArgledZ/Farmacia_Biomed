package DAO;

import config.Conexion;
import Entidades.Categoria;
import Entidades.Lote;
import Entidades.Producto;



import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LoteDAO {

    
        public List<Lote> listarLote(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         List<Lote> list=null;
          
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarlote()} ");
             
            list=new ArrayList<>();
            Lote em=null;
            rs = cstm.executeQuery();
            
            while(rs.next()){
                em =new Lote();
                em.setId_lote(rs.getInt("Id_lote"));
                em.getCategoria().setDes_categoria(rs.getString("Des_categoria"));
                em.getProducto().setReg_sanitario(rs.getString("Reg_sanitario"));
                em.getProducto().setId_producto(rs.getInt("Id_producto"));
                em.getProducto().setNombre_producto(rs.getString("Nombre_producto"));
                em.getProducto().setPrecio_compra(rs.getString("Precio_compra"));
                em.getProducto().setPrecio_venta(rs.getString("Precio_venta"));
                em.getProducto().setConcentracion_producto(rs.getString("Concentracion_producto"));
                em.setStock(rs.getString("stock"));
                em.setFecha_vencimiento(rs.getDate("Fecha_vencimiento"));
                em.getProveedor().setNom_persona(rs.getString("nomproveedor"));
                
                //em.setProducto(new Producto(rs.getInt("Id_producto")));
                //em.setProducto(new Producto(rs.getInt("Id_producto"),rs.getString("Nombre_producto")));
               
               
               
               
                
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
        
    //INSERTAR NUEVOOOO
        
          public boolean insertar(Lote lote){
        
       boolean confirmacion2=false;
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
     
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL painsertarproducto(?,?,?,?,?,?,?,?,?)}");
           cstm.setInt(1, lote.getCategoria().getId_categoria());
           cstm.setString(2, lote.getProducto().getReg_sanitario());
           cstm.setString(3,lote.getProducto().getNombre_producto());
           cstm.setString(4,lote.getProducto().getPrecio_compra());
           cstm.setString(5,lote.getProducto().getPrecio_venta());
           cstm.setString(6,lote.getProducto().getConcentracion_producto());
           cstm.setString(7,lote.getStock());
           cstm.setInt(8,lote.getProveedor().getId_persona());
           cstm.setDate(9, (Date) lote.getFecha_vencimiento());
          
          
           
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
        
        
     //INSERTAR
        
          public boolean insertarnuevolote(Lote lote){
        
       boolean confirmacion2=false;
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
     
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL painsertarnuevolote(?,?,?,?)}");
           
           cstm.setInt(1,lote.getProducto().getId_producto());   
           cstm.setString(2,lote.getStock());
           cstm.setInt(3,lote.getProveedor().getId_persona());
           cstm.setDate(4, (Date) lote.getFecha_vencimiento());
          
          
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
        
  //BUSCAR
        
       public List<Lote> buscarProducto(String lote){
        List<Lote> list=null;
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
           cstm.setString(1, lote);
           rs = cstm.executeQuery(); 
           
            list=new ArrayList<>();
            Lote em=null;
           
            while(rs.next()){
                em =new Lote();
                em.setId_lote(rs.getInt("Id_lote"));
                em.getCategoria().setDes_categoria(rs.getString("Des_categoria"));
                em.getProducto().setReg_sanitario(rs.getString("Reg_sanitario"));
                em.getProducto().setId_producto(rs.getInt("Id_producto"));
                em.getProducto().setNombre_producto(rs.getString("Nombre_producto"));
                em.getProducto().setPrecio_compra(rs.getString("Precio_compra"));
                em.getProducto().setPrecio_venta(rs.getString("Precio_venta"));
                em.getProducto().setConcentracion_producto(rs.getString("Concentracion_producto"));
                em.setStock(rs.getString("stock"));
                em.setFecha_vencimiento(rs.getDate("Fecha_vencimiento"));
                em.getProveedor().setNom_persona(rs.getString("nomproveedor"));
                
                //em.setProducto(new Producto(rs.getInt("Id_producto")));
                //em.setProducto(new Producto(rs.getInt("Id_producto"),rs.getString("Nombre_producto")));
               
               
               
               
                
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
       
         public boolean actualiza(Lote lote){
        
      
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
          
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL pamodificarproducto(?,?,?,?,?,?,?,?,?,?,?)}");
           cstm.setInt(1, lote.getProducto().getId_producto());
           cstm.setInt(2, lote.getCategoria().getId_categoria());
           cstm.setString(3, lote.getProducto().getReg_sanitario());
           cstm.setString(4,lote.getProducto().getNombre_producto());
           cstm.setString(5,lote.getProducto().getPrecio_compra());
           cstm.setString(6,lote.getProducto().getPrecio_venta());
           cstm.setString(7,lote.getProducto().getConcentracion_producto());
           cstm.setString(8,lote.getStock());
           cstm.setInt(9,lote.getProveedor().getId_persona());
           cstm.setDate(10, (Date) lote.getFecha_vencimiento());
           cstm.setInt(11, lote.getId_lote());
           
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

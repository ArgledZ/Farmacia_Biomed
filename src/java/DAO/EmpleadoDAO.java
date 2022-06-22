package DAO;

import config.Conexion;
import Entidades.Cargo;
import Entidades.Empleado;
import Entidades.Estadoempleado;
import Entidades.Tipodocumento;
import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {

    public Empleado IdentificarEmpleado(String user, String pass) {
        Connection con = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        Empleado em = null;
        try {
            con = Conexion.getConection();
            cstm = con.prepareCall("{ call identificarEmpleado(?, ?) } ");

            cstm.setString(1, user);
            cstm.setString(2, pass);

            rs = cstm.executeQuery();

            while (rs.next()) {
                em =  new Empleado();
                em.setId_persona(parseInt(rs.getString("Id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setNumero_identicacion(parseInt(rs.getString("numero_identificacion")));
                em.setUsuario(rs.getString("Usuario"));
                em.setClave(rs.getString("Clave"));
               
                
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (cstm != null) {
                    cstm.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        return em;
        
    }
    
        public List<Empleado> listarEmpleados(){
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
         List<Empleado> list=null;
          
       
        try {
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call palistarempleado()} ");
             
            list=new ArrayList<>();
            Empleado em=null;
            rs = cstm.executeQuery();
            
            while(rs.next()){
                em =new Empleado();
                em.setId_persona(parseInt(rs.getString("Id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento"),rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(parseInt(rs.getString("Numero_identificacion")));
                //em.setFecha_naci_persona(rs.getString("Fecha_naci_persona"));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setFecha_naci_persona(rs.getString("Fecha_naci_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setCargo(new Cargo(rs.getInt("Id_cargo")));
                em.setCargo(new Cargo(rs.getInt("Id_cargo"),rs.getString("Des_cargo")));
                em.setEstadoempleado(new Estadoempleado(rs.getInt("Id_estadoempleado")));
                em.setEstadoempleado(new Estadoempleado(rs.getInt("Id_estadoempleado"),rs.getString("des_estadoempleado")));
                em.setUsuario(rs.getString("Usuario"));
                em.setClave(rs.getString("Clave"));
                
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
        
          public boolean insertar(Empleado emple){
        
       boolean confirmacion2=false;
          Connection con=null;
        CallableStatement cstm1 = null;
        CallableStatement cstm = null;
        ResultSet rs=null;
        List<Empleado> list=null;
         Empleado em=null;
           try {
        con=Conexion.getConection();
         cstm1 = con.prepareCall("{ call pabuscarempleado(?)} ");
         cstm1.setInt(1, emple.getNumero_identicacion());
           rs = cstm1.executeQuery(); 
          
                   
               
                 if(rs.next()){
                 
                                      
                     return true;
                   
                 }else{
                 
                     
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL painsertarempleado(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
           cstm.setString(1, emple.getNom_persona());
           cstm.setString(2, emple.getApe_persona());
           cstm.setInt(3,emple.getTipodocumento().getId_tipo_documento());
           cstm.setInt(4,emple.getNumero_identicacion());
           cstm.setString(5,emple.getFecha_naci_persona());
           cstm.setString(6,emple.getNacioalidad_persona());
           cstm.setString(7,emple.getEmpresa_persona());
           cstm.setString(8,emple.getCorreo_persona());
           cstm.setString(9,emple.getTelf_persona());
           cstm.setString(10,emple.getDir_persona());
           cstm.setString(11,emple.getSex_persona());
           cstm.setInt(12, emple.getCargo().getId_cargo());
           cstm.setInt(13, emple.getEstadoempleado().getId_estadoempleado());
           cstm.setString(14,emple.getUsuario());
           cstm.setString(15,emple.getClave());
          
           
           confirmacion2 = cstm.execute();
               
                    return false;
        
         
              
                 }
             
          
        
       } catch (Exception ex) {
            
            System.out.println(ex.getMessage());
            
        }
         
        return true;
   
    }     
        
        
        
        
  //BUSCAREMPLEADO
        
       public List<Empleado> buscarCliente(String empleado){
        List<Empleado> list=null;
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
           
           cstm = con.prepareCall("{ call pabuscarempleado(?)} ");
           cstm.setString(1, empleado);
           rs = cstm.executeQuery(); 
           
            list=new ArrayList<>();
            Empleado em=null;
           
            
            
            while(rs.next()){
                
               em =new Empleado();
                em.setId_persona(parseInt(rs.getString("Id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("id_tipo_documento"),rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(parseInt(rs.getString("Numero_identificacion")));
                em.setEdad_persona(parseInt(rs.getString("Edad_persona")));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setCargo(new Cargo(rs.getInt("Id_cargo"),rs.getString("Des_cargo")));
                em.setEstadoempleado(new Estadoempleado(rs.getInt("Id_estadoempleado"),rs.getString("des_estadoempleado")));
                em.setUsuario(rs.getString("Usuario"));
                em.setClave(rs.getString("Clave"));
                
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
        
       
      //BUSCAREMPLEADO
        
       public Empleado obtenerPorId(int id){
       
        Connection con=null;
        CallableStatement cstm = null;
        ResultSet rs=null;
           Empleado em=null;
        try {
           
            con=Conexion.getConection();
           
           cstm = con.prepareCall("{ call obtenerporid(?)} ");
           cstm.setInt(1, id);
           rs = cstm.executeQuery(); 
           
            while(rs.next()){
                
                em =new Empleado();
                em.setId_persona(parseInt(rs.getString("Id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("id_tipo_documento"),rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(parseInt(rs.getString("Numero_identificacion")));
                em.setEdad_persona(parseInt(rs.getString("Edad_persona")));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setCargo(new Cargo(rs.getInt("Id_cargo"),rs.getString("Des_cargo")));
                em.setEstadoempleado(new Estadoempleado(rs.getInt("Id_estadoempleado"),rs.getString("des_estadoempleado")));
                em.setUsuario(rs.getString("Usuario"));
                em.setClave(rs.getString("Clave"));
                
               
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
        return em;
    }    
    //MODIFICAR EMPLEADO
       
         public boolean actualiza(Empleado emple){
        
      
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
          
          
           con=Conexion.getConection();
           cstm = con.prepareCall("{CALL pamodificarempleado(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
           cstm.setInt(1, emple.getId_persona());
           cstm.setString(2, emple.getNom_persona());
           cstm.setString(3, emple.getApe_persona());
           cstm.setInt(4,emple.getTipodocumento().getId_tipo_documento());
           cstm.setInt(5,emple.getNumero_identicacion());
           cstm.setString(6,emple.getFecha_naci_persona());
           cstm.setString(7,emple.getNacioalidad_persona());
           cstm.setString(8,emple.getEmpresa_persona());
           cstm.setString(9,emple.getCorreo_persona());
           cstm.setString(10,emple.getTelf_persona());
           cstm.setString(11,emple.getDir_persona());
           cstm.setString(12,emple.getSex_persona());
           cstm.setInt(13, emple.getCargo().getId_cargo());
           cstm.setInt(14, emple.getEstadoempleado().getId_estadoempleado());
           cstm.setString(15,emple.getUsuario());
           cstm.setString(16,emple.getClave());
           
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
       
     public boolean Eliminar(Empleado empleado){
        
       boolean confirmacion=false;
          Connection con=null;
        CallableStatement cstm = null;
        
       
         try {
          
          
            con=Conexion.getConection();
           cstm = con.prepareCall("{ call paeliminarpersona(?,?)} ");
           cstm.setInt(1, empleado.getId_persona());
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

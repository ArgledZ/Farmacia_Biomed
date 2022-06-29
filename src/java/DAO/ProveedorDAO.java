
package DAO;


import config.Conexion;
import Entidades.Proveedor;
import Entidades.Tipodocumento;
import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 *
 * @author Gustavo
 */
public class ProveedorDAO {
    
    
      public List<Proveedor> listarProveedores(){
        Connection con = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<Proveedor> list = null;

        try {
            con = Conexion.getConection();

            cstm = con.prepareCall("{ call palistarproveedor() } ");

            list = new ArrayList<>();
            Proveedor em = null;
            rs = cstm.executeQuery();

            while (rs.next()) {
                em = new Proveedor();
                em.setId_persona(parseInt(rs.getString("id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                //em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento"), rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(rs.getString("numero_identificacion"));
                em.setEdad_persona(parseInt(rs.getString("Edad_persona")));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setObservacion(rs.getString("Observacion"));
                em.setFecha_naci_persona(rs.getString("Fecha_naci_persona"));
                
                list.add(em);
            }
            return list;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (cstm != null) {
                    cstm.close();
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
        return list;
    }  
 
}

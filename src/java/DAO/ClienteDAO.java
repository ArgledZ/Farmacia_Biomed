package DAO;

import config.Conexion;
import Entidades.Cliente;
import Entidades.Tipodocumento;
import static java.lang.Integer.parseInt;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ClienteDAO {

    public List<Cliente> listarClientes() {
        Connection con = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<Cliente> list = null;

        try {
            con = Conexion.getConection();

            cstm = con.prepareCall("{ call palistarcliente() } ");

            list = new ArrayList<>();
            Cliente em = null;
            rs = cstm.executeQuery();

            while (rs.next()) {
                em = new Cliente();
                em.setId_persona(parseInt(rs.getString("Id_persona")));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento"), rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(rs.getString("Numero_identificacion"));
                em.setEdad_persona(parseInt(rs.getString("Edad_persona")));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setFec_regis_cliente(rs.getString("Fec_regis_cliente"));
                em.setPuntos(rs.getInt("puntos"));
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

    //INSERTAR
    public boolean insertar(Cliente cliente) {

        boolean confirmacion2 = false;
        Connection con = null;
        CallableStatement cstm1 = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<Cliente> list = null;
        Cliente em = null;
        try {
            con = Conexion.getConection();
            cstm1 = con.prepareCall("{ call pabuscarcliente(?)} ");
            cstm1.setString(1, cliente.getNumero_identicacion());
            rs = cstm1.executeQuery();

            if (rs.next()) {

                return true;

            } else {

                con = Conexion.getConection();
                cstm = con.prepareCall("{CALL painsertarcliente(?,?,?,?,?,?,?,?,?,?,?)}");
                cstm.setString(1, cliente.getNom_persona());
                cstm.setString(2, cliente.getApe_persona());
                cstm.setInt(3, cliente.getTipodocumento().getId_tipo_documento());
                cstm.setString(4, cliente.getNumero_identicacion());
                cstm.setString(5, cliente.getFecha_naci_persona());
                cstm.setString(6, cliente.getNacioalidad_persona());
                cstm.setString(7, cliente.getEmpresa_persona());
                cstm.setString(8, cliente.getCorreo_persona());
                cstm.setString(9, cliente.getTelf_persona());
                cstm.setString(10, cliente.getDir_persona());
                cstm.setString(11, cliente.getSex_persona());

                confirmacion2 = cstm.execute();

                return false;

            }

        } catch (Exception ex) {

            System.out.println(ex.getMessage());

        }

        return true;

    }

    //BUSCAREMPLEADO
    public List<Cliente> buscarCliente(String clienteado) {
        List<Cliente> list = null;
        Connection con = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        try {
            //con=Conexion.getConexion();
            //String sql="select * from cliente where Apellidos like '"+cliente+"%'";

            //pstm=con.prepareStatement(sql);
            //rs=pstm.executeQuery();
            //list=new ArrayList<>();
            //Cliente client=null;
            con = Conexion.getConection();

            cstm = con.prepareCall("{ call pabuscarcliente(?)} ");
            cstm.setString(1, clienteado);
            rs = cstm.executeQuery();

            list = new ArrayList<>();
            Cliente em = null;

            while (rs.next()) {
                em = new Cliente();
                em = new Cliente();
                em.setId_persona(rs.getInt("Id_persona"));
                em.setNom_persona(rs.getString("Nom_persona"));
                em.setApe_persona(rs.getString("Ape_persona"));
                em.setTipodocumento(new Tipodocumento(rs.getInt("Id_tipo_documento")));
                em.setTipodocumento(new Tipodocumento(rs.getInt("id_tipo_documento"), rs.getString("Des_tipo_documento")));
                em.setNumero_identicacion(rs.getString("Numero_identificacion"));
                em.setEdad_persona(parseInt(rs.getString("Edad_persona")));
                em.setNacioalidad_persona(rs.getString("Nacionalidad_persona"));
                em.setEmpresa_persona(rs.getString("Empresa_persona"));
                em.setCorreo_persona(rs.getString("Correo_persona"));
                em.setTelf_persona(rs.getString("Telf_persona"));
                em.setDir_persona(rs.getString("Dir_persona"));
                em.setSex_persona(rs.getString("Sex_persona"));
                em.setFec_regis_cliente(rs.getString("Fec_regis_cliente"));
                em.setPuntos(rs.getInt("puntos"));

                list.add(em);
            }

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
                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
        return list;
    }

    //MODIFICAR EMPLEADO
    public boolean actualiza(Cliente cliente) {

        Connection con = null;
        CallableStatement cstm = null;

        try {

            con = Conexion.getConection();
            cstm = con.prepareCall("{CALL pamodificarcliente(?,?,?,?,?,?,?,?,?,?,?,?)}");
            cstm.setInt(1, cliente.getId_persona());
            cstm.setString(2, cliente.getNom_persona());
            cstm.setString(3, cliente.getApe_persona());
            cstm.setInt(4, cliente.getTipodocumento().getId_tipo_documento());
            cstm.setString(5, cliente.getNumero_identicacion());
            cstm.setInt(6, cliente.getEdad_persona());
            cstm.setString(7, cliente.getNacioalidad_persona());
            cstm.setString(8, cliente.getEmpresa_persona());
            cstm.setString(9, cliente.getCorreo_persona());
            cstm.setString(10, cliente.getTelf_persona());
            cstm.setString(11, cliente.getDir_persona());
            cstm.setString(12, cliente.getSex_persona());

            cstm.executeUpdate();

        } catch (Exception ex) {

            System.out.println(ex.getMessage());

        } finally {

            try {

                if (cstm != null) {
                    cstm.close();
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());

            }

        }
        return true;

    }

    //ELIMINAR EMPLEADO
    public boolean Eliminar(Cliente cliente) {

        boolean confirmacion = false;
        Connection con = null;
        CallableStatement cstm = null;

        try {

            con = Conexion.getConection();
            cstm = con.prepareCall("{ call paeliminarpersona(?,?)} ");
            cstm.setInt(1, cliente.getId_persona());
            cstm.setInt(2, 1);
            confirmacion = cstm.execute();

        } catch (Exception ex) {

            System.out.println(ex.getMessage());

        } finally {

            try {

                if (cstm != null) {
                    cstm.close();
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());

            }

        }
        return true;

    }

}

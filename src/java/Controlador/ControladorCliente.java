/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import DAO.ClienteDAO;
import DAO.TipodocumentoDAO;
import Entidades.Cliente;
import Entidades.Tipodocumento;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author gcamo
 */
@WebServlet(name = "ControladorCliente", urlPatterns = {"/ControladorCliente"})
public class ControladorCliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private HttpSession sesion;
    Cliente obj = new Cliente();
    ClienteDAO objDao = new ClienteDAO();
    TipodocumentoDAO tpdoc = new TipodocumentoDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");

        if (menu.equals("Principal")) {
            response.sendRedirect("Principal.jsp");

        }
        if(menu.equals("Clientes")){
            sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List lista = objDao.listarClientes();
                    sesion.setAttribute("listaClientes", lista);
                    
                    List listatd = tpdoc.listardocumentos();
                    sesion.setAttribute("listadocumentos", listatd);
                    /*
                    List listacar = cargo.listarCargos();
                    sesion.setAttribute("listacargos", listacar);

                    List listaestado = estado.listarEstados();
                    sesion.setAttribute("listaestado", listaestado);
                    */
        response.sendRedirect("Cliente.jsp");
        }
        if (menu.equals("Cliente")) {
            switch (accion) {
                case "Listar":
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List lista = objDao.listarClientes();
                    sesion.setAttribute("listaClientes", lista);
                    
                    List listatd = tpdoc.listardocumentos();
                    sesion.setAttribute("listadocumentos", listatd);

                    break;

                case "Agregar":

                    //obj.setId_persona(Integer.parseInt(request.getParameter("id")));
                    obj.setNom_persona(request.getParameter("nom"));
                    obj.setApe_persona(request.getParameter("ape"));
                    obj.setTipodocumento(new Tipodocumento(Integer.parseInt(request.getParameter("tpdoc"))));
                    obj.setNumero_identicacion(Integer.parseInt(request.getParameter("numero")));
                    obj.setFecha_naci_persona(request.getParameter("edad"));
                    obj.setNacioalidad_persona(request.getParameter("nacio"));
                    obj.setEmpresa_persona(request.getParameter("empresa"));
                    obj.setCorreo_persona(request.getParameter("correo"));
                    obj.setTelf_persona(request.getParameter("telf"));
                    obj.setDir_persona(request.getParameter("dire"));
                    obj.setSex_persona(request.getParameter("sexo"));

                    boolean resp = objDao.insertar(obj);

                   if (resp == true) {
                        
                   } else {
                                                     
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List listaobj = objDao.listarClientes();
                    sesion.setAttribute("listaClientes", listaobj);
                    List listatdobj = tpdoc.listardocumentos();
                    sesion.setAttribute("listadocumentos", listatdobj);
                    response.sendRedirect("Cliente.jsp");           
                    }

                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Eliminar":

                    obj.setId_persona(Integer.parseInt(request.getParameter("id")));
                    objDao.Eliminar(obj);
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List listas = objDao.listarClientes();
                    sesion.setAttribute("listaClientes", listas);                
                    response.sendRedirect("Cliente.jsp");                                
                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Editar":

                    obj.setId_persona(Integer.parseInt(request.getParameter("id")));
                    obj.setNom_persona(request.getParameter("nom"));
                    obj.setApe_persona(request.getParameter("ape"));
                    obj.setTipodocumento(new Tipodocumento(Integer.parseInt(request.getParameter("tpdoc"))));
                    obj.setNumero_identicacion(Integer.parseInt(request.getParameter("numero")));
                    obj.setFecha_naci_persona(request.getParameter("edad"));
                    obj.setNacioalidad_persona(request.getParameter("nacio"));
                    obj.setEmpresa_persona(request.getParameter("empresa"));
                    obj.setCorreo_persona(request.getParameter("correo"));
                    obj.setTelf_persona(request.getParameter("telf"));
                    obj.setDir_persona(request.getParameter("dire"));
                    obj.setSex_persona(request.getParameter("sexo"));
                    
                    objDao.actualiza(obj);

                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List listas2 = objDao.listarClientes();
                    sesion.setAttribute("listaClientes", listas2); 
                    response.sendRedirect("Cliente.jsp"); ;
                     
                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");

                    break;
                default:
                    throw new AssertionError();

            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

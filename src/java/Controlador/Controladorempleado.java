/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import DAO.CargoDAO;
import DAO.EmpleadoDAO;
import DAO.EstadoempleadoDAO;
import DAO.TipodocumentoDAO;
import Entidades.Cargo;
import Entidades.Empleado;
import Entidades.Estadoempleado;
import Entidades.Tipodocumento;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Gustavo
 */
public class Controladorempleado extends HttpServlet {

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
    Empleado em = new Empleado();
    EmpleadoDAO emdao = new EmpleadoDAO();
    TipodocumentoDAO tpdoc = new TipodocumentoDAO();
    EstadoempleadoDAO estado = new EstadoempleadoDAO();

    CargoDAO cargo = new CargoDAO();
    int ide;
    private int cod = 0;
    private String mensaje = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");

        if (menu.equals("Principal")) {
            response.sendRedirect("Principal.jsp");

        }
        if(menu.equals("Empleados")){
            sesion = request.getSession();
                    sesion.removeAttribute("listaEmpleados");
                    List lista = emdao.listarEmpleados();
                    sesion.setAttribute("listaEmpleados", lista);

                    List listatd = tpdoc.listardocumentos();
                    sesion.setAttribute("listadocumentos", listatd);

                    List listacar = cargo.listarCargos();
                    sesion.setAttribute("listacargos", listacar);

                    List listaestado = estado.listarEstados();
                    sesion.setAttribute("listaestado", listaestado);
        response.sendRedirect("Empleado.jsp");
        }
        if (menu.equals("Editar")) {

            cod = Integer.parseInt(request.getParameter("id"));

            try {

                sesion = request.getSession();
                sesion.removeAttribute("msgPostOperacion");
                sesion.removeAttribute("listaEmpleado");
                sesion.removeAttribute("msgListado");
                sesion.removeAttribute("msg");

                sesion.setAttribute("msg", cod);

                // response.sendRedirect("newjsp.jsp");
            } catch (Exception e) {

            }

        }

        if (menu.equals("Empleado")) {
            switch (accion) {
                case "Listar":
                    sesion = request.getSession();
                    sesion.removeAttribute("listaEmpleados");
                    List lista = emdao.listarEmpleados();
                    sesion.setAttribute("listaEmpleados", lista);

                    List listatd = tpdoc.listardocumentos();
                    sesion.setAttribute("listadocumentos", listatd);

                    List listacar = cargo.listarCargos();
                    sesion.setAttribute("listacargos", listacar);

                    List listaestado = estado.listarEstados();
                    sesion.setAttribute("listaestado", listaestado);

                    break;

                case "Agregar":

                    //em.setId_persona(Integer.parseInt(request.getParameter("id")));
                    em.setNom_persona(request.getParameter("nom"));
                    em.setApe_persona(request.getParameter("ape"));
                    em.setTipodocumento(new Tipodocumento(Integer.parseInt(request.getParameter("tpdoc"))));
                    em.setNumero_identicacion(request.getParameter("numero"));
                    em.setFecha_naci_persona(request.getParameter("edad"));
                    em.setNacioalidad_persona(request.getParameter("nacio"));
                    em.setEmpresa_persona(request.getParameter("empresa"));
                    em.setCorreo_persona(request.getParameter("correo"));
                    em.setTelf_persona(request.getParameter("telf"));
                    em.setDir_persona(request.getParameter("dire"));
                    em.setSex_persona(request.getParameter("sexo"));
                    em.setCargo(new Cargo(Integer.parseInt(request.getParameter("cargo"))));
                    em.setEstadoempleado(new Estadoempleado(Integer.parseInt(request.getParameter("estado"))));
                    em.setUsuario(request.getParameter("usu"));
                    em.setClave(request.getParameter("clave"));

                    boolean resp = emdao.insertar(em);

                   if (resp == true) {
                        
                   } else {
                    sesion = request.getSession();
                    sesion.removeAttribute("listaEmpleados");
                    List listame = emdao.listarEmpleados();
                    sesion.setAttribute("listaEmpleados", listame);
                    
                    response.sendRedirect("Empleado.jsp");
                    }

                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Eliminar":

                    em.setId_persona(Integer.parseInt(request.getParameter("id")));
                    emdao.Eliminar(em);
                    sesion = request.getSession();
                    sesion.removeAttribute("listaEmpleados");
                    List listas = emdao.listarEmpleados();
                    sesion.setAttribute("listaEmpleados", listas);
                    
                    
                    response.sendRedirect("Empleado.jsp");
                    
                    
                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Editar":

                    em.setId_persona(Integer.parseInt(request.getParameter("id")));
                    em.setNom_persona(request.getParameter("nom"));
                    em.setApe_persona(request.getParameter("ape"));
                    em.setTipodocumento(new Tipodocumento(Integer.parseInt(request.getParameter("tpdoc"))));
                    em.setNumero_identicacion(request.getParameter("numero"));
                    em.setFecha_naci_persona(request.getParameter("edad"));
                    em.setNacioalidad_persona(request.getParameter("nacio"));
                    em.setEmpresa_persona(request.getParameter("empresa"));
                    em.setCorreo_persona(request.getParameter("correo"));
                    em.setTelf_persona(request.getParameter("telf"));
                    em.setDir_persona(request.getParameter("dire"));
                    em.setSex_persona(request.getParameter("sexo"));
                    em.setCargo(new Cargo(Integer.parseInt(request.getParameter("cargo"))));
                    em.setEstadoempleado(new Estadoempleado(Integer.parseInt(request.getParameter("estado"))));
                    em.setUsuario(request.getParameter("usu"));
                    em.setClave(request.getParameter("clave"));

                    emdao.actualiza(em);

                    sesion = request.getSession();
                    sesion.removeAttribute("listaEmpleados");
                    List listas2 = emdao.listarEmpleados();
                    sesion.setAttribute("listaEmpleados", listas2);
                    
                    
                    response.sendRedirect("Empleado.jsp");
                     
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import DAO.ClienteDAO;
import DAO.TipodocumentoDAO;
import Entidades.Cliente;
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
    Cliente cl = new Cliente();
    ClienteDAO cldao = new ClienteDAO();
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
                    sesion.removeAttribute("listaEmpleado");;
                    List lista = cldao.listarClientes();
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

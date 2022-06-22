/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import DAO.EmpleadoDAO;
import Entidades.Empleado;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Gustavo
 */
public class validar extends HttpServlet {

    EmpleadoDAO edao = new EmpleadoDAO();
    Empleado em = new Empleado();
    private String usu = null;
    private String mensaje = null;
    private String mensaje1 = null;
    private String mensaje2 = null;
    private HttpSession sesion;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet validar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet validar at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        String accion = request.getParameter("accion");
        if (accion.equals("Ingresar")) {
            String user = request.getParameter("usuario");
            String pass = request.getParameter("contrasena");
            em = edao.IdentificarEmpleado(user, pass);
            if (em != null) {
                sesion = request.getSession();
                usu = em.getNom_persona();
                sesion.setAttribute("usuario", usu);
                request.getRequestDispatcher("Controladorlogin?menu=Principal").forward(request, response);
                mensaje1 = em.getNom_persona();
                mensaje2 = em.getApe_persona();
                //  response.sendRedirect("Principal.jsp");
            } else {

                response.sendRedirect("index.jsp");
                mensaje = " <script>Swal.fire({\n"
                        + " title: '<strong style=\"color:black;font-family:OswaldLight;\">Error </strong>',\n"
                        + " text:\"Usuario y/o Contraseña incorrectos\",\n"
                        + " type: 'error',\n"
                        + " allowOutsideClick:false,\n"
                        + " showCancelButton: false,\n"
                        + " confirmButtonColor: '#DB0000',\n"
                        + " cancelButtonColor: '#d33',\n"
                        + " confirmButtonText: 'ok',\n"
                        + " cancelButtonText: 'No, Cancelar',\n"
                        + " })</script>";

            }

        } else {
            sesion.setAttribute("usuario", null);
            response.sendRedirect("index.jsp");

        }

        sesion = request.getSession();
        sesion.removeAttribute("msgListado");
        sesion.removeAttribute("msgListado1");
        sesion.removeAttribute("msgListado2");
        sesion.setAttribute("msg", mensaje);
        sesion.setAttribute("msg1", mensaje1);
        sesion.setAttribute("msg2", mensaje2);
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

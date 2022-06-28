/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import DAO.CategoriaDAO;
import DAO.LoteDAO;
import DAO.ProductoDAO;
import DAO.ProveedorDAO;
import Entidades.Lote;
import Entidades.Producto;
import Entidades.Categoria;
import Entidades.Proveedor;
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
@WebServlet(name = "ControladorProducto", urlPatterns = {"/ControladorProducto"})
public class ControladorProducto extends HttpServlet {

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
    Lote obj = new Lote();
    LoteDAO objDao = new LoteDAO();
    CategoriaDAO cateDao = new CategoriaDAO();
    ProductoDAO prodDao  = new ProductoDAO();
    ProveedorDAO provDao = new ProveedorDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");

        if (menu.equals("Principal")) {
            response.sendRedirect("Principal.jsp");

        }
        if(menu.equals("Productos")){
            sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List lista = objDao.listarLote();
                    sesion.setAttribute("listaProductos", lista);                   
                    List listapr = prodDao.listarProductos();
                    sesion.setAttribute("listadeProductos", listapr);
                    List listapv = cateDao.listarCategorias();
                    sesion.setAttribute("listadeCategorias", listapv);
                    List listaca = provDao.listarProveedores();
                    sesion.setAttribute("listadeProveedores", listaca);
                    
        response.sendRedirect("Producto.jsp");
        }
        
        if (menu.equals("Producto")) {
            switch (accion) {
                case "Listar":
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List lista = objDao.listarLote();
                    sesion.setAttribute("listaProductos", lista);                   
                    List listapr = prodDao.listarProductos();
                    sesion.setAttribute("listadeProductos", listapr);
                    List listapv = cateDao.listarCategorias();
                    sesion.setAttribute("listadeCategorias", listapv);
                    List listaca = provDao.listarProveedores();
                    sesion.setAttribute("listadeProveedores", listaca);

                    break;

                case "Agregar":
               
                    obj.setId_lote(Integer.parseInt(request.getParameter("numero")));
                    obj.getCategoria().setId_categoria(Integer.parseInt(request.getParameter("numero")));
                    obj.getProducto().setId_producto(Integer.parseInt(request.getParameter("numero")));
                    obj.getProducto().setReg_sanitario(request.getParameter("nom"));
                    obj.getProducto().setNombre_producto(request.getParameter("nom"));
                    obj.getProducto().setPrecio_compra(request.getParameter("nom"));
                    obj.getProducto().setPrecio_venta(request.getParameter("nom"));
                    obj.getProducto().setConcentracion_producto(request.getParameter("nom"));
                    obj.setFecha_vencimiento(request.getParameter("nom"));
                    obj.getProveedor().setId_persona(Integer.parseInt(request.getParameter("numero")));
                    obj.getProveedor().setNom_persona(request.getParameter("nom"));
                    
                    boolean resp = objDao.insertar(obj);

                   if (resp == true) {
                        
                   } else {
                                                     
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List listaobj = objDao.listarLote();
                    sesion.setAttribute("listaProductos", listaobj);                   
                    List listaprobj = prodDao.listarProductos();
                    sesion.setAttribute("listadeProductos", listaprobj);
                    List listapvobj = cateDao.listarCategorias();
                    sesion.setAttribute("listadeCategorias", listapvobj);
                    List listacaobj = provDao.listarProveedores();
                    sesion.setAttribute("listadeProveedores", listacaobj);
                    
                    response.sendRedirect("Producto.jsp");           
                    }

                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Eliminar":
                    
                    obj.getProducto().setId_producto(Integer.parseInt(request.getParameter("id")));
                    objDao.Eliminar(obj.getProducto());
                    sesion = request.getSession();
                    sesion.removeAttribute("listaProductos");
                    sesion.removeAttribute("listaProveedores");
                    sesion.removeAttribute("listaClientes");
                    sesion.removeAttribute("listaEmpleado");
                    List listaobj = objDao.listarLote();
                    sesion.setAttribute("listaProductos", listaobj);                   
                    List listaprobj = prodDao.listarProductos();
                    sesion.setAttribute("listadeProductos", listaprobj);
                    List listapvobj = cateDao.listarCategorias();
                    sesion.setAttribute("listadeCategorias", listapvobj);
                    List listacaobj = provDao.listarProveedores();
                    sesion.setAttribute("listadeProveedores", listacaobj);
                    
                    response.sendRedirect("Producto.jsp");                                 
                    //request.getRequestDispatcher("Controladorempleado1?menu=Empleado&accion=Listar");
                    break;

                case "Editar":

                    
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

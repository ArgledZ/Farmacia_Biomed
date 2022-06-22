
package Entidades;

import java.util.Date;

/**
 *
 * @author Gustavo
 */
public class Lote {
    
    private int id_lote;
    private Producto producto;
    private String stock;
    private Proveedor proveedor;
    private Date fecha_vencimiento;
    private Categoria categoria;
    private Persona persona;

    public Lote() {
        
        producto = new Producto();
        proveedor = new Proveedor();
        categoria = new Categoria();
        persona = new Persona();
    }

    public Lote(int id_lote, Producto producto, String stock, Proveedor proveedor, Date fecha_vencimiento, Categoria categoria, Persona persona) {
        this.id_lote = id_lote;
        this.producto = producto;
        this.stock = stock;
        this.proveedor = proveedor;
        this.fecha_vencimiento = fecha_vencimiento;
        this.categoria = categoria;
        this.persona = persona;
    }
    
    public Lote(int id_lote){
     this.id_lote = id_lote;
    
    }

    public int getId_lote() {
        return id_lote;
    }

    public void setId_lote(int id_lote) {
        this.id_lote = id_lote;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Persona getPersona() {
        return persona;
    }

    public void setPersona(Persona persona) {
        this.persona = persona;
    }

    
  
    
  
    
    
    
    
}

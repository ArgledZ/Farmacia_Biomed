/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Producto {
    
    
    private int id_producto;
    private Categoria categoria;
    private String reg_sanitario;
    private String Nombre_producto;
    private String precio_compra;
    private String precio_venta;
    private String concentracion_producto;

    public Producto() {
        categoria= new Categoria();
    }

    public Producto(int id_producto, Categoria categoria, String reg_sanitario, String Nombre_producto, String precio_compra, String precio_venta, String concentracion_producto) {
        this.id_producto = id_producto;
        this.categoria = categoria;
        this.reg_sanitario = reg_sanitario;
        this.Nombre_producto = Nombre_producto;
        this.precio_compra = precio_compra;
        this.precio_venta = precio_venta;
        this.concentracion_producto = concentracion_producto;
    }

    public Producto(int id_producto) {
       this.id_producto = id_producto;
    }
    public Producto(int id_producto,String reg_sanitario, String Nombre_producto,String precio_compra,String precio_venta,String concentracion_producto) {
       this.id_producto = id_producto;
       this.reg_sanitario = reg_sanitario;
       this.Nombre_producto = Nombre_producto;
       this.precio_compra = precio_compra;
       this.precio_venta = precio_venta;
       this.concentracion_producto = concentracion_producto;
    }
    public Producto(String reg_sanitario, String Nombre_producto,String precio_compra,String precio_venta,String concentracion_producto) {
       
       this.reg_sanitario = reg_sanitario;
       this.Nombre_producto = Nombre_producto;
       this.precio_compra = precio_compra;
       this.precio_venta = precio_venta;
       this.concentracion_producto = concentracion_producto;
    } 
    
   
    public Producto(int id_producto, String Nombre_producto) {
       this.id_producto = id_producto;
       this.Nombre_producto = Nombre_producto;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public String getReg_sanitario() {
        return reg_sanitario;
    }

    public void setReg_sanitario(String reg_sanitario) {
        this.reg_sanitario = reg_sanitario;
    }

    public String getNombre_producto() {
        return Nombre_producto;
    }

    public void setNombre_producto(String Nombre_producto) {
        this.Nombre_producto = Nombre_producto;
    }

    public String getPrecio_compra() {
        return precio_compra;
    }

    public void setPrecio_compra(String precio_compra) {
        this.precio_compra = precio_compra;
    }

    public String getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(String precio_venta) {
        this.precio_venta = precio_venta;
    }

    public String getConcentracion_producto() {
        return concentracion_producto;
    }

    public void setConcentracion_producto(String concentracion_producto) {
        this.concentracion_producto = concentracion_producto;
    }
    
    public String toString()
    {
       return Nombre_producto;
    }
    
    
    @Override
    public boolean equals(Object obj)
    {
        return this.getCategoria().getId_categoria() == ((Categoria) obj).getId_categoria();
    } 
    
}

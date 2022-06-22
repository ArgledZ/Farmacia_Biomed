/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Estadoempleado {
    
     private int Id_estadoempleado;
    private String des_estadoempleado;

    public Estadoempleado() {
    }
    
     public Estadoempleado(int Id_estadoempleado) {
      this.Id_estadoempleado = Id_estadoempleado;    
    }

    public Estadoempleado(int Id_estadoempleado, String des_estadoempleado) {
        this.Id_estadoempleado = Id_estadoempleado;
        this.des_estadoempleado = des_estadoempleado;
    }

    public int getId_estadoempleado() {
        return Id_estadoempleado;
    }

    public void setId_estadoempleado(int Id_estadoempleado) {
        this.Id_estadoempleado = Id_estadoempleado;
    }

    public String getDes_estadoempleado() {
        return des_estadoempleado;
    }

    public void setDes_estadoempleado(String des_estadoempleado) {
        this.des_estadoempleado = des_estadoempleado;
    }
    
     @Override
    public String toString()
    {
    return des_estadoempleado;
    }
    
     @Override
    public boolean equals(Object obj)
    {
        return this.Id_estadoempleado == ((Estadoempleado) obj).Id_estadoempleado;
    }
    
}

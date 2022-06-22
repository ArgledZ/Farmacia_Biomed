/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

/**
 *
 * @author Gustavo
 */
public class Cargo {
    
    private int Id_cargo;
    private String des_cargo;

    public Cargo() {
    }

     public Cargo(int Id_cargo) {
   this.Id_cargo = Id_cargo;
     }

    public Cargo(int Id_cargo, String des_cargo) {
        this.Id_cargo = Id_cargo;
        this.des_cargo = des_cargo;
    }

    public int getId_cargo() {
        return Id_cargo;
    }

    public void setId_cargo(int Id_cargo) {
        this.Id_cargo = Id_cargo;
    }

    public String getDes_cargo() {
        return des_cargo;
    }

    public void setDes_cargo(String des_cargo) {
        this.des_cargo = des_cargo;
    }
    
    public String toString()
    {
    return des_cargo;
    }
    
    
    @Override
    public boolean equals(Object obj)
    {
        return this.Id_cargo == ((Cargo) obj).Id_cargo;
    }
}

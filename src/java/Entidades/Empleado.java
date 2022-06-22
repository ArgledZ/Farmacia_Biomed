
package Entidades;

import java.util.Date;

/**
 *
 * @author Gustavo
 */
public class Empleado extends Persona {
   
    private Cargo cargo;
    private Estadoempleado estadoempleado;
    private String usuario;
    private String clave;

    public Empleado() {    
        cargo= new Cargo();
        estadoempleado= new Estadoempleado();
    }

  

    public Empleado(Cargo cargo, Estadoempleado estadoempleado, String usuario, String clave, int Id_persona, String Nom_persona, String Ape_persona, Tipodocumento tipodocumento, int Numero_identicacion, int Edad_persona, String Nacioalidad_persona, String Empresa_persona, String Correo_persona, String Telf_persona, String Fecha_naci_persona, String Dir_persona, String Sex_persona) {
        super(Id_persona, Nom_persona, Ape_persona, tipodocumento, Numero_identicacion, Edad_persona, Nacioalidad_persona, Empresa_persona, Correo_persona, Telf_persona, Fecha_naci_persona, Dir_persona, Sex_persona);
        this.cargo = cargo;
        this.estadoempleado = estadoempleado;
        this.usuario = usuario;
        this.clave = clave;
    }


   

    public Cargo getCargo() {
        return cargo;
    }

    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }

    public Estadoempleado getEstadoempleado() {
        return estadoempleado;
    }

    public void setEstadoempleado(Estadoempleado estadoempleado) {
        this.estadoempleado = estadoempleado;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

   

   

   

    
    
    
}
